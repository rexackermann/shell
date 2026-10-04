#!/system/bin/sh
# rena-iso.sh — export rena.img RAW over USB (imgdrive "Stage 2", via isodrive)
#
# The PC sees the still-encrypted LUKS image as a USB drive. While exported,
# the phone must NOT use it, so 'on' tears down the local stack first and
# pauses the rena-mount.sh daemon; 'off' stops the export and brings it back.
#
#   rena-iso.sh on  [--ro] [-f]   release local mount, export over USB (RW unless --ro)
#   rena-iso.sh off [-n]          stop export, remount locally (-n: leave unmounted)
#   rena-iso.sh fix [on|off]      hard-reset everything, then re-apply on/off
#                                 (no arg = whatever was last requested)
#   rena-iso.sh status
#
#   -f  skip the "USB cable connected" check
#
# Needs: rena-mount.sh (service.d), isodrive binary, Termux nsenter/cryptsetup.
# Log: /data/adb/rena/iso.log

# ============================ CONFIG (match rena-mount.sh) ==================
SD_DEV="/dev/block/mmcblk1p1"
SD_UUID=""                       # empty = use /data/adb/rena/sd.uuid (rena-mount.sh pin)
SD_MNT="/mnt/sd"
IMG_REL="rena.img"
NAME="rena"
RM="/mnt/media_rw/$NAME"

MOUNTER="/data/adb/service.d/rena-mount.sh"
STATE_DIR="/data/adb/rena"

T="/data/data/com.termux/files/usr/bin"
CRYPTSETUP="$T/cryptsetup"
NSENTER="$T/nsenter"
BLKID="/system/bin/blkid"
# first executable one wins
ISODRIVE_CANDIDATES="/system/bin/isodrive /data/adb/imgdrive/bin/isodrive $T/isodrive"
# ============================================================================

mkdir -p "$STATE_DIR"
[ -z "$SD_UUID" ] && [ -r "$STATE_DIR/sd.uuid" ] && SD_UUID="$(cat "$STATE_DIR/sd.uuid")"

IMG="$SD_MNT/$IMG_REL"
IMG_NAME="$(basename "$IMG_REL")"
SD_NAME="$(basename "$SD_DEV")"
LOGFILE="$STATE_DIR/iso.log"
STATEFILE="$STATE_DIR/iso.state"

ISO_BIN=""
for c in $ISODRIVE_CANDIDATES; do [ -x "$c" ] && { ISO_BIN="$c"; break; }; done

log() { printf '%s %s\n' "$(date '+%m-%d %H:%M:%S')" "$*" >> "$LOGFILE" 2>/dev/null; printf '%s\n' "$*"; return 0; }
die() { log "ERROR: $*"; exit 1; }

g_run()     { "$NSENTER" -t 1 -m -- "$@"; }
g_mounted() { g_run cat /proc/self/mountinfo 2>/dev/null | awk -v t="$1" '$5==t{f=1} END{exit !f}'; }
umount_path() {
    i=0
    while g_mounted "$1" && [ "$i" -lt 6 ]; do
        g_run umount "$1" >/dev/null 2>&1 || g_run umount -l "$1" >/dev/null 2>&1
        i=$((i+1))
    done
}

# ---------------------------------------------------------------------------
# USB / gadget helpers (configfs, same checks imgdrive uses)
# ---------------------------------------------------------------------------
usb_connected() {
    for f in /sys/class/udc/*/state; do
        [ -r "$f" ] || continue
        case "$(cat "$f" 2>/dev/null)" in
            attached|powered|default|addressed|configured|suspended) return 0 ;;
        esac
    done
    if [ -r /sys/class/android_usb/android0/state ]; then
        case "$(cat /sys/class/android_usb/android0/state 2>/dev/null)" in
            CONFIGURED|CONNECTED|configured|connected) return 0 ;;
        esac
    fi
    return 1
}

# file currently set as the mass-storage LUN (any gadget) — empty if none
iso_file() {
    for f in /config/usb_gadget/*/functions/mass_storage.*/lun.0/file; do
        [ -r "$f" ] || continue
        v="$(cat "$f" 2>/dev/null)"
        [ -n "$v" ] && { printf '%s\n' "$v"; return 0; }
    done
    return 1
}
iso_udc() {
    for u in /config/usb_gadget/*/UDC; do
        [ -r "$u" ] || continue
        v="$(cat "$u" 2>/dev/null)"
        [ -n "$v" ] && { printf '%s\n' "$v"; return 0; }
    done
    return 1
}
iso_active() { [ -n "$(iso_file)" ] && [ -n "$(iso_udc)" ]; }

force_eject() {
    for d in /config/usb_gadget/*/functions/mass_storage.*/lun.0; do
        [ -d "$d" ] || continue
        [ -w "$d/forced_eject" ] && echo 1 > "$d/forced_eject" 2>/dev/null
        [ -w "$d/file" ] && : > "$d/file" 2>/dev/null
    done
}

# re-enumerate the gadget (briefly drops the USB link, incl. USB adb)
rebind_udc() {
    for u in /config/usb_gadget/*/UDC; do
        [ -w "$u" ] || continue
        cur="$(cat "$u" 2>/dev/null)"
        [ -n "$cur" ] || cur="$(ls /sys/class/udc 2>/dev/null | head -n1)"
        [ -n "$cur" ] || continue
        log "rebinding UDC $cur"
        : > "$u" 2>/dev/null; sleep 1
        printf '%s' "$cur" > "$u" 2>/dev/null
        return 0
    done
    return 1
}

stop_iso() {
    [ -n "$(iso_file)" ] || return 0
    log "stopping isodrive (was exporting: $(iso_file))"
    sync
    [ -n "$ISO_BIN" ] && g_run "$ISO_BIN" >/dev/null 2>&1
    i=0; while [ -n "$(iso_file)" ] && [ "$i" -lt 5 ]; do sleep 1; i=$((i+1)); done
    if [ -n "$(iso_file)" ]; then
        log "isodrive did not release the LUN — forcing eject"
        force_eject; sleep 2
    fi
    [ -z "$(iso_file)" ]
}

# ---------------------------------------------------------------------------
# Local-stack detection (so we never export an image the phone still uses)
# ---------------------------------------------------------------------------
mapper_active() { "$CRYPTSETUP" status "$NAME" >/dev/null 2>&1; }
image_loops() {
    for f in /sys/block/loop*/loop/backing_file; do
        [ -r "$f" ] || continue
        case "$(cat "$f" 2>/dev/null)" in
            *"/$IMG_NAME"|*"/$IMG_NAME (deleted)") basename "$(dirname "$(dirname "$f")")" ;;
        esac
    done
}
local_up() { mapper_active || [ -n "$(image_loops)" ] || g_mounted "$RM"; }

sd_check() {
    [ -b "$SD_DEV" ] || { log "no SD card at $SD_DEV"; return 1; }
    uuid="$("$BLKID" -o value -s UUID "$SD_DEV" 2>/dev/null)"
    [ -n "$uuid" ] || { log "cannot read UUID of $SD_DEV"; return 1; }
    [ -n "$SD_UUID" ] || { log "no card UUID pinned — run: sh $MOUNTER pin"; return 1; }
    [ "$uuid" = "$SD_UUID" ] || { log "WRONG CARD ($uuid, expected $SD_UUID)"; return 1; }
}

need_tools() {
    [ -x "$NSENTER" ]    || die "nsenter not found: $NSENTER"
    [ -x "$CRYPTSETUP" ] || die "cryptsetup not found: $CRYPTSETUP"
}

# ---------------------------------------------------------------------------
# Commands
# ---------------------------------------------------------------------------
cmd_on() {
    mode="-rw"; force=0
    for a in "$@"; do
        case "$a" in --ro|-ro) mode="" ;; -f|--force) force=1 ;; esac
    done
    log "===== ISO ON ($([ -n "$mode" ] && echo RW || echo RO)) ====="
    need_tools
    [ -n "$ISO_BIN" ] || die "isodrive binary not found (tried: $ISODRIVE_CANDIDATES)"
    [ -x "$MOUNTER" ] || die "rena-mount.sh not found at $MOUNTER (needed to release the local stack)"
    sd_check || exit 1
    if [ "$force" -eq 0 ] && ! usb_connected; then die "USB cable not connected (use -f to force)"; fi

    stop_iso || die "could not stop the previous export"

    log "releasing local stack (rena-mount.sh umount)"
    sh "$MOUNTER" umount >/dev/null 2>&1 || log "warning: cleanup reported problems"
    local_up && die "local stack still up (mapper/loop/mount) — refusing to export a live image; try: $0 fix off"

    # clean slate for the SD mount, then mount it in the global namespace
    umount_path "$SD_MNT"
    mkdir -p "$SD_MNT"
    g_run mount "$SD_DEV" "$SD_MNT" >/dev/null 2>&1 || die "could not mount $SD_DEV on $SD_MNT"
    [ -f "$IMG" ] || { umount_path "$SD_MNT"; die "image not found: $IMG"; }

    sync
    log "starting isodrive: $IMG $mode"
    out="$(g_run "$ISO_BIN" "$IMG" $mode 2>&1)"; rc=$?
    [ -n "$out" ] && printf '%s\n' "$out" | while IFS= read -r l; do log "  isodrive> $l"; done
    [ "$rc" -eq 0 ] || die "isodrive failed (exit $rc)"

    i=0; while [ "$(iso_file)" != "$IMG" ] && [ "$i" -lt 8 ]; do sleep 1; i=$((i+1)); done
    [ "$(iso_file)" = "$IMG" ] || die "isodrive did not export the expected image (LUN: '$(iso_file)')"
    iso_udc >/dev/null || { log "UDC unbound after start — rebinding"; rebind_udc; sleep 1; }
    iso_active || die "export set but gadget not active (try: $0 fix on)"

    echo on > "$STATEFILE"
    log "===== ISO ACTIVE: $IMG exported over USB ====="
}

cmd_off() {
    keep=0
    for a in "$@"; do case "$a" in -n|--no-local) keep=1 ;; esac; done
    log "===== ISO OFF ====="
    need_tools
    stop_iso || die "could not stop the export (try: $0 fix off)"
    echo off > "$STATEFILE"
    umount_path "$SD_MNT"
    if [ "$keep" -eq 1 ]; then
        log "export stopped; local stack left unmounted (rena-mount.sh stays paused)"
        return 0
    fi
    [ -x "$MOUNTER" ] || { log "rena-mount.sh not found — local stack NOT remounted"; return 0; }
    log "remounting local stack (rena-mount.sh mount)"
    sh "$MOUNTER" mount >/dev/null 2>&1 && log "===== LOCAL MOUNT READY =====" \
        || die "local remount failed — see /data/adb/rena/mount.log"
}

cmd_fix() {
    target="$1"
    [ -n "$target" ] || target="$(cat "$STATEFILE" 2>/dev/null)"
    [ "$target" = "on" ] || target="off"
    log "===== FIX (target: $target) ====="
    need_tools

    log "state before:"; show_status | while IFS= read -r l; do log "  $l"; done

    # 1. the export
    stop_iso || log "warning: export still present after forced eject"
    # 2. every local layer, twice if the first pass was dirty
    if [ -x "$MOUNTER" ]; then
        sh "$MOUNTER" umount >/dev/null 2>&1 || { log "first cleanup pass dirty — retrying"; sleep 2; sh "$MOUNTER" umount >/dev/null 2>&1; }
    fi
    for l in $(image_loops); do
        log "detaching stray loop $l"
        "$T/losetup" -d "/dev/block/$l" >/dev/null 2>&1
    done
    umount_path "$SD_MNT"
    local_up && log "warning: local stack still not clean"

    case "$target" in
        on)  cmd_on -f; rebind_udc; sleep 1; iso_active && log "gadget active after rebind" ;;
        off) cmd_off ;;
    esac
}

show_status() {
    echo "intended : $(cat "$STATEFILE" 2>/dev/null || echo unknown)"
    echo "export   : $(iso_file || echo none)   UDC: $(iso_udc || echo unbound)"
    echo "usb link : $(usb_connected && echo connected || echo not connected)"
    echo "isodrive : ${ISO_BIN:-NOT FOUND}"
    echo "mapper   : $(mapper_active && echo active || echo -)   loops: $(image_loops | tr '\n' ' ')"
    echo "local mnt: $(g_mounted "$RM" && echo "$RM" || echo -)   sd: $(g_mounted "$SD_MNT" && echo "$SD_MNT" || echo -)"
    [ -f "$STATE_DIR/paused" ] && echo "daemon   : paused (rena-mount.sh)"
    if iso_active && local_up; then echo "PROBLEM  : exported AND still used locally — run: $0 fix"; fi
}

case "$1" in
    on)     shift; cmd_on "$@" ;;
    off)    shift; cmd_off "$@" ;;
    fix)    shift; cmd_fix "$1" ;;
    status) show_status ;;
    *)      sed -n '2,17p' "$0" | sed 's/^# \{0,1\}//'; exit 1 ;;
esac
