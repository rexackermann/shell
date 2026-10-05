#!/system/bin/sh
# rena-iso.sh — export rena.img RAW over USB
#
# The PC sees the raw LUKS2 container as a USB drive. While exported,
# the phone must NOT use it locally.
#
#   rena-iso.sh on  [--ro] [-f]   release local mount, export over USB
#   rena-iso.sh off [-n]          stop export, remount locally (-n: leave unmounted)
#   rena-iso.sh fix [on|off]      hard-reset everything, re-apply on/off
#   rena-iso.sh status
#
#   --ro  export read-only
#   -f    skip USB cable check
#   -n    (off only) don't remount locally after stopping export
#
# portableusb8 (rena-portable.sh) shares the same USB LUN: 'on' replaces it, 'off' leaves it alone.
#
# Log: /data/adb/rena/iso.log

# ============================ CONFIG =======================================
SD_DEV="/dev/block/mmcblk1p1"
SD_UUID=""                       # empty = use /data/adb/rena/sd.uuid
SD_MNT="/mnt/sd"
IMG_REL="rena.img"
NAME="rena"
RM="/mnt/media_rw/$NAME"

MOUNTER="/data/adb/service.d/rena-mount.sh"
STATE_DIR="/data/adb/rena"

T="/data/data/com.termux/files/usr/bin"
LOSETUP="$T/losetup"
CRYPTSETUP="$T/cryptsetup"
NSENTER="$T/nsenter"
BLKID="/system/bin/blkid"

LUN="/config/usb_gadget/g1/functions/mass_storage.0/lun.0"
UDC_PATH="/config/usb_gadget/g1/UDC"
UDC="musb-hdrc"
# ============================================================================

mkdir -p "$STATE_DIR"
[ -z "$SD_UUID" ] && [ -r "$STATE_DIR/sd.uuid" ] && SD_UUID="$(cat "$STATE_DIR/sd.uuid")"

IMG="$SD_MNT/$IMG_REL"
IMG_NAME="$(basename "$IMG_REL")"
SD_NAME="$(basename "$SD_DEV")"
LOGFILE="$STATE_DIR/iso.log"
STATEFILE="$STATE_DIR/iso.state"

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
# Loop helpers
# ---------------------------------------------------------------------------
image_loops() {
    for f in /sys/block/loop*/loop/backing_file; do
        [ -r "$f" ] || continue
        case "$(cat "$f" 2>/dev/null)" in
            *"/$IMG_NAME"|*"/$IMG_NAME (deleted)")
                echo "/dev/block/$(basename "$(dirname "$(dirname "$f")")")" ;;
        esac
    done
}

detach_image_loops() {
    for l in $(image_loops); do
        log "  detach loop $l"
        "$LOSETUP" -d "$l" >/dev/null 2>&1
    done
}

lun_loop() { cat "$LUN/file" 2>/dev/null; }

# True when the LUN currently exports portableusb8.img (rena-portable.sh), not rena.img.
# Stateless: decided from the loop device's backing file.
lun_is_portable() {
    f="$(lun_loop)"; [ -n "$f" ] || return 1
    lb="${f##*/}"
    case "$(cat "/sys/block/$lb/loop/backing_file" 2>/dev/null)" in
        *"/portableusb8.img"|*"/portableusb8.img (deleted)") return 0 ;;
    esac
    return 1
}

# ---------------------------------------------------------------------------
# USB gadget helpers
# ---------------------------------------------------------------------------
usb_connected() {
    for f in /sys/class/udc/*/state; do
        [ -r "$f" ] || continue
        case "$(cat "$f" 2>/dev/null)" in
            attached|powered|default|addressed|configured|suspended) return 0 ;;
        esac
    done
    [ -r /sys/class/android_usb/android0/state ] || return 1
    case "$(cat /sys/class/android_usb/android0/state 2>/dev/null)" in
        CONFIGURED|CONNECTED|configured|connected) return 0 ;;
    esac
    return 1
}

udc_active() {
    v="$(cat "$UDC_PATH" 2>/dev/null)"
    [ -n "$v" ]
}

rebind_udc() {
    log "rebinding UDC $UDC"
    : > "$UDC_PATH" 2>/dev/null
    sleep 1
    printf '%s' "$UDC" > "$UDC_PATH" 2>/dev/null
}

clear_lun() {
    [ -w "$LUN/forced_eject" ] && echo 1 > "$LUN/forced_eject" 2>/dev/null
    : > "$LUN/file" 2>/dev/null
    sync
}

stop_export() {
    local cur
    cur="$(lun_loop)"
    [ -n "$cur" ] || return 0
    log "clearing LUN (was: $cur)"
    sync
    clear_lun
    sleep 1
    cur="$(lun_loop)"
    [ -n "$cur" ] && { log "LUN still set to $cur after clear"; return 1; }
    return 0
}

# ---------------------------------------------------------------------------
# Local stack helpers
# ---------------------------------------------------------------------------
mapper_active() { "$CRYPTSETUP" status "$NAME" >/dev/null 2>&1; }
local_up() { mapper_active || [ -n "$(image_loops)" ] || g_mounted "$RM"; }

sd_check() {
    [ -b "$SD_DEV" ] || { log "no SD card at $SD_DEV"; return 1; }
    uuid="$("$BLKID" -o value -s UUID "$SD_DEV" 2>/dev/null)"
    [ -n "$uuid" ] || { log "cannot read UUID of $SD_DEV"; return 1; }
    [ -n "$SD_UUID" ] || { log "no UUID pinned — run: sh $MOUNTER pin"; return 1; }
    [ "$uuid" = "$SD_UUID" ] || { log "WRONG CARD ($uuid, expected $SD_UUID)"; return 1; }
}

need_tools() {
    [ -x "$NSENTER" ]    || die "nsenter not found: $NSENTER"
    [ -x "$CRYPTSETUP" ] || die "cryptsetup not found: $CRYPTSETUP"
    [ -x "$LOSETUP" ]    || die "losetup not found: $LOSETUP"
    [ -d "$LUN" ]        || die "configfs LUN not found: $LUN"
}

# ---------------------------------------------------------------------------
# Commands
# ---------------------------------------------------------------------------
cmd_on() {
    ro=0; force=0
    for a in "$@"; do
        case "$a" in --ro|-ro) ro=1 ;; -f|--force) force=1 ;; esac
    done
    log "===== ISO ON ($([ "$ro" -eq 1 ] && echo RO || echo RW)) ====="
    need_tools
    sd_check || exit 1
    [ "$force" -eq 0 ] && ! usb_connected && die "USB cable not connected (use -f to skip)"

    # stop any existing export (this also drops portableusb8 if it was exported)
    lun_is_portable && log "portableusb8 is currently exported — replacing it (it is restored after 'off')"
    stop_export || die "could not clear LUN"

    # release local stack (runs rena-mount.sh cleanup_all, which closes portableusb8 first)
    log "releasing local stack"
    [ -x "$MOUNTER" ] && sh "$MOUNTER" umount >/dev/null 2>&1
    local_up && die "local stack still up — refusing to export live image; try: $0 fix on"

    # mount SD in global namespace so we can reach the image file
    umount_path "$SD_MNT"
    mkdir -p "$SD_MNT"
    g_run mount "$SD_DEV" "$SD_MNT" >/dev/null 2>&1 || die "could not mount $SD_DEV on $SD_MNT"
    [ -f "$IMG" ] || { umount_path "$SD_MNT"; die "image not found: $IMG"; }

    # attach loop with direct-io (required for USB gadget to stream cleanly)
    log "attaching loop (sector-size 4096, direct-io)"
    LOOP="$("$LOSETUP" -f --show --sector-size 4096 --direct-io=on "$IMG" 2>/dev/null)"
    [ -n "$LOOP" ] || { umount_path "$SD_MNT"; die "losetup failed"; }
    log "loop = $LOOP"

    # verify LUKS header is readable
    "$CRYPTSETUP" isLuks "$LOOP" >/dev/null 2>&1 || {
        "$LOSETUP" -d "$LOOP" >/dev/null 2>&1
        umount_path "$SD_MNT"
        die "not a valid LUKS image on $LOOP"
    }
    log "LUKS header ok"

    # set read-only flag before writing LUN
    echo "$ro" > "$LUN/ro" 2>/dev/null

    # point LUN at the loop device
    sync
    printf '%s' "$LOOP" > "$LUN/file" 2>/dev/null
    sleep 1
    got="$(lun_loop)"
    [ "$got" = "$LOOP" ] || die "LUN file mismatch (got: '$got', expected: '$LOOP')"

    # ensure UDC is bound
    udc_active || { log "UDC unbound — rebinding"; rebind_udc; sleep 1; }
    udc_active || die "UDC still unbound after rebind"

    echo on > "$STATEFILE"
    log "===== ISO ACTIVE: $LOOP ($IMG) exported over USB ====="
    log "  On PC: sudo cryptsetup open --key-file <key> /dev/sdX rena"
}

cmd_off() {
    keep=0
    for a in "$@"; do case "$a" in -n|--no-local) keep=1 ;; esac; done
    log "===== ISO OFF ====="
    need_tools
    # The LUN may belong to portableusb8 (rena is local, rena.img is NOT exported).
    # Stopping that export / re-mounting rena from here would be wrong and could pull
    # /mnt/sd out from under the live local stack.
    if lun_is_portable; then
        log "rena.img is not exported (the USB LUN belongs to portableusb8) — nothing to do"
        echo off > "$STATEFILE"
        return 0
    fi
    stop_export || log "warning: could not clear LUN cleanly"
    detach_image_loops
    echo off > "$STATEFILE"
    if [ "$keep" -eq 1 ]; then
        log "export stopped; local stack left as-is (-n)"
        return 0
    fi
    umount_path "$SD_MNT"
    [ -x "$MOUNTER" ] || { log "mounter not found — not remounting"; return 0; }
    log "remounting local stack (portableusb8 is re-applied automatically afterwards)"
    sh "$MOUNTER" mount >/dev/null 2>&1 \
        && log "===== LOCAL MOUNT READY =====" \
        || die "local remount failed — see /data/adb/rena/mount.log"
}

cmd_fix() {
    target="$1"
    [ -n "$target" ] || target="$(cat "$STATEFILE" 2>/dev/null)"
    [ "$target" = "on" ] || target="off"
    log "===== FIX (target: $target) ====="
    need_tools
    log "state before:"; show_status | while IFS= read -r l; do log "  $l"; done

    stop_export || log "warning: LUN not cleared cleanly"
    [ -x "$MOUNTER" ] && sh "$MOUNTER" umount >/dev/null 2>&1 || true
    sleep 1
    detach_image_loops
    umount_path "$SD_MNT"
    local_up && log "warning: local stack still not clean after fix"

    case "$target" in
        on)
            cmd_on -f
            rebind_udc; sleep 1
            udc_active && log "gadget active after rebind" || log "warning: UDC still unbound"
            ;;
        off) cmd_off ;;
    esac
}

show_status() {
    echo "intended : $(cat "$STATEFILE" 2>/dev/null || echo unknown)"
    echo "LUN file : $(lun_loop || echo none)$(lun_is_portable && echo '  (portableusb8)')"
    echo "LUN ro   : $(cat "$LUN/ro" 2>/dev/null || echo ?)"
    echo "UDC      : $(cat "$UDC_PATH" 2>/dev/null || echo unbound)"
    echo "USB link : $(usb_connected && echo connected || echo not connected)"
    echo "loops    : $(image_loops | tr '\n' ' ' || echo none)"
    echo "mapper   : $(mapper_active && echo active || echo -)"
    echo "local mnt: $(g_mounted "$RM" && echo "$RM" || echo -)   sd: $(g_mounted "$SD_MNT" && echo "$SD_MNT" || echo -)"
    [ -f "$STATE_DIR/paused" ] && echo "daemon   : paused (rena-mount.sh)"
    if [ -n "$(lun_loop)" ] && ! lun_is_portable && local_up; then
        echo "PROBLEM  : exported AND local stack still up — run: $0 fix"
    fi
}

case "$1" in
    on)     shift; cmd_on "$@" ;;
    off)    shift; cmd_off "$@" ;;
    fix)    shift; cmd_fix "$1" ;;
    status) show_status ;;
    *)      sed -n '2,16p' "$0" | sed 's/^# \{0,1\}//'; exit 1 ;;
esac
