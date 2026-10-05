#!/system/bin/sh
# rena-portable.sh — portableusb8.img: a plain-F2FS image stored INSIDE the unlocked rena volume
#
#   rena.img (LUKS2+F2FS, on SD) -> $RM/portableusb8.img (F2FS) -> one of three modes:
#     usb     image file -> USB mass-storage LUN via isodrive -rw (no loop) (PC sees a plain F2FS drive); phone does NOT mount it
#     system  loop -> f2fs -> bindfs at /sdcard/rena/portableusb8
#     off     fully detached
#
#   rena-portable.sh create [SIZE]        make + format the image (default 8G); NEVER overwrites,
#                                         never touches a running export/mount
#   rena-portable.sh usb    [--ro] [--takeover]
#   rena-portable.sh system [--takeover]
#   rena-portable.sh off
#   rena-portable.sh toggle               usb <-> system
#   rena-portable.sh status
#   rena-portable.sh fix                  hard reset, then re-apply the desired mode
#   rena-portable.sh restore              (called by rena-mount.sh after READY) re-apply desired mode
#   rena-portable.sh down-hook            (called by rena-mount.sh cleanup_all) tear down, never fails
#
#   --ro         export read-only (remembered)
#   --takeover   if rena.img is exported raw over USB, run rena-iso.sh off first
#
# Desired mode is persisted in /data/adb/rena/portable.mode (default: usb), so it survives
# reboots, SD re-insertion, watchdog heals and rena-iso on/off cycles.
# Log: /data/adb/rena/portable.log

# ============================ CONFIG =======================================
NAME="rena"
PNAME="portableusb8"
RM="/mnt/media_rw/$NAME"                    # raw rena f2fs mount (use this, not FUSE paths)
UV="/data/media/0/$NAME"                    # rena bindfs (what Android sees)
PUB="/storage/emulated/0/$NAME"
PIMG="$RM/$PNAME.img"
PRAW="/mnt/media_rw/$PNAME"                 # raw mount of the inner f2fs (system mode)
PUV="$UV/$PNAME"                            # bindfs target == /sdcard/rena/portableusb8
PSIZE="8G"
PLABEL="PORTABLE"
DEFAULT_MODE="usb"
BIND_UID=1023
BIND_GID=1023
BIND_PERMS=0770
FSCK_OPTS="-f -a"                           # check 'fsck.f2fs --help' of your Termux build

MOUNTER="/data/adb/service.d/rena-mount.sh"
ISO="$(command -v rena-iso.sh 2>/dev/null)" # only used by --takeover

T="/data/data/com.termux/files/usr/bin"
LOSETUP="$T/losetup"
CRYPTSETUP="$T/cryptsetup"
BINDFS="$T/bindfs"
NSENTER="$T/nsenter"
EXPORT_PATH="/sdcard/rena/portableusb8.img"   # path given to isodrive (the one that works on this device)
ISODRIVE=""                                 # empty = auto-detect (nitanmarcel/isodrive-magisk); fallback = same configfs writes
MKFS_F2FS=""                                # empty = auto-detect (Termux, then Android's own binaries)
FSCK_F2FS=""                                # empty = auto-detect
BLKID="/system/bin/blkid"

LUN="/config/usb_gadget/g1/functions/mass_storage.0/lun.0"
UDC_PATH="/config/usb_gadget/g1/UDC"
UDC="musb-hdrc"

STATE_DIR="/data/adb/rena"
# ============================================================================

# first executable candidate wins (PATH lookup + fixed paths: Android ships make_f2fs/fsck.f2fs itself)
find_tool() {
    for n in "$@"; do
        case "$n" in
            /*) [ -x "$n" ] && { echo "$n"; return 0; } ;;
            *)  p="$(command -v "$n" 2>/dev/null)"; [ -n "$p" ] && [ -x "$p" ] && { echo "$p"; return 0; } ;;
        esac
    done
    return 1
}
[ -n "$ISODRIVE" ] || ISODRIVE="$(find_tool /system/bin/isodrive /system/xbin/isodrive /data/adb/modules/isodrive/system/bin/isodrive isodrive)"
[ -n "$MKFS_F2FS" ] || MKFS_F2FS="$(find_tool "$T/mkfs.f2fs" /system/bin/mkfs.f2fs /system/bin/make_f2fs /vendor/bin/make_f2fs /system/xbin/make_f2fs mkfs.f2fs make_f2fs)"
[ -n "$FSCK_F2FS" ] || FSCK_F2FS="$(find_tool "$T/fsck.f2fs" /system/bin/fsck.f2fs /vendor/bin/fsck.f2fs fsck.f2fs)"

mkdir -p "$STATE_DIR"
LOGFILE="$STATE_DIR/portable.log"
MODEFILE="$STATE_DIR/portable.mode"
ROFILE="$STATE_DIR/portable.ro"
PLOCK="$STATE_DIR/plock"
LAZY=1
P_LOOP=""
TAKEOVER=0

# propagated Android views of the bindfs target (same list rena-mount.sh uses for rena itself)
PVIS="$PUB/$PNAME
/mnt/androidwritable/0/emulated/0/$NAME/$PNAME
/mnt/installer/0/emulated/0/$NAME/$PNAME
/mnt/user/0/emulated/0/$NAME/$PNAME
/mnt/pass_through/0/emulated/0/$NAME/$PNAME"

log() { printf '%s %s\n' "$(date '+%m-%d %H:%M:%S')" "$*" >> "$LOGFILE" 2>/dev/null; [ -t 1 ] && printf '%s\n' "$*"; return 0; }

# ---------------------------------------------------------------------------
# Global namespace helpers (same approach as rena-mount.sh)
# ---------------------------------------------------------------------------
g_run()      { "$NSENTER" -t 1 -m -- "$@"; }
mi()         { g_run cat /proc/self/mountinfo 2>/dev/null; }
g_mounted()  { mi | awk -v t="$1" '$5==t{f=1} END{exit !f}'; }
mps_by_dev() { mi | awk -v m="$1" '$3==m{print $5}'; }
bindfs_on()  { mi | awk -v s="$1" '{for(i=7;i<=NF;i++) if($i=="-"){ if($(i+1) ~ /^fuse/ && $(i+2)==s) print $5; break }}'; }

# plain umount x4; lazy only as last resort (LAZY=1) because a lazily detached mount
# can still pin the loop device — p_down verifies that afterwards.
umount_path() {
    i=0
    while g_mounted "$1" && [ "$i" -lt 4 ]; do
        log "  umount $1"
        g_run umount "$1" >/dev/null 2>&1
        g_mounted "$1" || break
        sleep 1; i=$((i+1))
    done
    if g_mounted "$1" && [ "$LAZY" = 1 ]; then
        log "  busy — lazy umount $1"
        g_run umount -l "$1" >/dev/null 2>&1
    fi
    g_mounted "$1" && return 1
    return 0
}

try() {
    _out="$("$@" 2>&1)"; _rc=$?
    if [ "$_rc" -ne 0 ]; then
        log "    '$1' failed (rc=$_rc)"
        [ -n "$_out" ] && printf '%s\n' "$_out" | while IFS= read -r _l; do log "      $_l"; done
    fi
    return "$_rc"
}

# ---------------------------------------------------------------------------
# Own lock (NEVER rena-mount's lock: its hook runs while that lock is held)
# ---------------------------------------------------------------------------
p_lock() {
    n=0; max="${1:-60}"
    while ! mkdir "$PLOCK" 2>/dev/null; do
        p="$(cat "$PLOCK/pid" 2>/dev/null)"
        if [ -n "$p" ] && ! kill -0 "$p" 2>/dev/null; then rm -rf "$PLOCK"; continue; fi
        n=$((n+1)); [ "$n" -gt "$max" ] && return 1
        sleep 1
    done
    echo $$ > "$PLOCK/pid"
}
p_unlock() { rm -rf "$PLOCK"; }
locked() {
    p_lock 60 || { log "could not get lock (stale? rm -rf $PLOCK)"; return 1; }
    "$@"; _rc=$?
    p_unlock
    return $_rc
}
# teardown must happen even if the lock is stuck: correctness beats serialisation
locked_soft() {
    got=1
    p_lock 20 || { log "lock busy — proceeding without it"; got=0; }
    "$@"; _rc=$?
    [ "$got" = 1 ] && p_unlock
    return $_rc
}

# ---------------------------------------------------------------------------
# Loop helpers
# ---------------------------------------------------------------------------
p_loops() {
    for f in /sys/block/loop*/loop/backing_file; do
        [ -r "$f" ] || continue
        case "$(cat "$f" 2>/dev/null)" in
            *"/$PNAME.img"|*"/$PNAME.img (deleted)")
                echo "/dev/block/$(basename "$(dirname "$(dirname "$f")")")" ;;
        esac
    done
}

p_detach() {
    n=0
    while [ -n "$(p_loops)" ] && [ "$n" -lt 4 ]; do
        for l in $(p_loops); do
            log "  detach $l"
            "$LOSETUP" -d "$l" >/dev/null 2>&1
        done
        sleep 1; n=$((n+1))
    done
    [ -z "$(p_loops)" ]
}

# sector-size 4096 + direct-io: same attach as rena-iso.sh (stable USB streaming, nested loop safe)
p_attach() {
    P_LOOP="$("$LOSETUP" -f --show --sector-size 4096 --direct-io=on "${1:-$PIMG}" 2>>"$LOGFILE")"
    [ -n "$P_LOOP" ] && log "loop = $P_LOOP"
}

# ---------------------------------------------------------------------------
# USB gadget helpers
# ---------------------------------------------------------------------------
lun_file() { cat "$LUN/file" 2>/dev/null; }

# none | nolun | ours | stale | foreign
# usb mode exports the image FILE itself (isodrive style), so the LUN file is a path.
# A loop device is still recognised (older versions / rena-iso's rena.img export).
lun_state() {
    [ -d "$LUN" ] || { echo nolun; return; }
    f="$(lun_file)"
    [ -n "$f" ] || { echo none; return; }
    case "$f" in
        *"/$PNAME.img"|*"/$PNAME.img (deleted)") echo ours; return ;;
        /dev/*loop*) ;;
        *) echo foreign; return ;;
    esac
    lb="${f##*/}"
    bf="$(cat "/sys/block/$lb/loop/backing_file" 2>/dev/null)"
    [ -n "$bf" ] || { echo stale; return; }
    case "$bf" in
        *"/$PNAME.img"|*"/$PNAME.img (deleted)") echo ours ;;
        *) echo foreign ;;
    esac
}

# Export regular file $1, read-only flag $2 (0|1), in PID 1's mount namespace.
# isodrive CREATES the mass_storage.0 function if the USB HAL dropped it.
export_file() {
    ro="$2"
    # The path handed to the gadget matters on this device: the raw f2fs path
    # (/mnt/media_rw/rena/...) is accepted by the LUN but the PC does not get the drive;
    # the /sdcard path (bindfs+FUSE view) works. So try the working path first.
    #   direct = run like the manual command, ns = inside PID 1's mount namespace
    for cand in "direct|$EXPORT_PATH" "ns|$UV/$PNAME.img" "ns|$PIMG"; do
        mode="${cand%%|*}"; p="${cand#*|}"
        [ "$mode" = direct ] && [ ! -e "$p" ] && { log "  skip $p (not visible here)"; continue; }
        if [ -n "$ISODRIVE" ]; then
            log "isodrive $p $([ "$ro" = 1 ] && echo '(ro)' || echo -rw)  [$mode]"
            if [ "$mode" = ns ]; then
                if [ "$ro" = 1 ]; then g_run "$ISODRIVE" "$p" >>"$LOGFILE" 2>&1; else g_run "$ISODRIVE" "$p" -rw >>"$LOGFILE" 2>&1; fi
            else
                if [ "$ro" = 1 ]; then "$ISODRIVE" "$p" >>"$LOGFILE" 2>&1; else "$ISODRIVE" "$p" -rw >>"$LOGFILE" 2>&1; fi
            fi
        else
            [ "$mode" = ns ] || continue
            log "isodrive not found — built-in configfs sequence ($p)"
            u="$(cat "$UDC_PATH" 2>/dev/null)"; [ -n "$u" ] || u="$UDC"
            g_run sh -c '
                G="${1%/UDC}"; F="$G/functions/mass_storage.0"; L="$F/lun.0"
                : > "$1"
                [ -d "$F" ] || mkdir "$F"
                C="$(ls -d "$G"/configs/*/ 2>/dev/null | head -n 1)"; C="${C%/}"
                [ -n "$C" ] && [ ! -e "$C/mass_storage.0" ] && ln -s "$F" "$C/mass_storage.0"
                : > "$L/file"; echo 0 > "$L/cdrom" 2>/dev/null
                echo "$2" > "$L/ro"; printf "%s" "$3" > "$L/file"
                sleep 1; printf "%s" "$4" > "$1"
            ' sh "$UDC_PATH" "$ro" "$p" "$u" >>"$LOGFILE" 2>&1
        fi
        sleep 1
        [ "$(lun_file)" = "$p" ] && { log "  LUN now: $p"; return 0; }
        log "  LUN is '$(lun_file)', wanted '$p' — trying next path"
    done
    return 1
}

# f2fs magic (0xF2F52010 LE) at offset 1024, read straight from the file
file_is_f2fs() {
    m="$(dd if="$1" bs=1 skip=1024 count=4 2>/dev/null | od -An -tx1 | tr -d ' \n')"
    [ "$m" = "1020f5f2" ]
}

clear_lun() {
    [ -w "$LUN/forced_eject" ] && echo 1 > "$LUN/forced_eject" 2>/dev/null
    : > "$LUN/file" 2>/dev/null
    sync
    sleep 1
}

udc_active() { [ -n "$(cat "$UDC_PATH" 2>/dev/null)" ]; }
rebind_udc() {
    log "rebinding UDC $UDC"
    : > "$UDC_PATH" 2>/dev/null; sleep 1
    printf '%s' "$UDC" > "$UDC_PATH" 2>/dev/null
}
usb_connected() {
    for f in /sys/class/udc/*/state; do
        [ -r "$f" ] || continue
        case "$(cat "$f" 2>/dev/null)" in
            attached|powered|default|addressed|configured|suspended) return 0 ;;
        esac
    done
    return 1
}

# ---------------------------------------------------------------------------
# rena (parent) health
# ---------------------------------------------------------------------------
rena_healthy() {
    "$CRYPTSETUP" status "$NAME" >/dev/null 2>&1 && g_mounted "$RM" && g_mounted "$UV"
}

# Bring rena up if needed. Called WITHOUT our lock held (rena's cleanup hook takes it).
ensure_rena() {
    rena_healthy && return 0
    if [ "$(lun_state)" = foreign ]; then
        if [ "$TAKEOVER" = 1 ] && [ -n "$ISO" ]; then
            log "rena.img is exported raw — running rena-iso.sh off (--takeover)"
            sh "$ISO" off >/dev/null 2>&1
        else
            log "rena.img seems exported raw over USB (LUN busy by another image)."
            log "  run: rena-iso.sh off     (or retry with --takeover)"
            return 1
        fi
    fi
    [ -x "$MOUNTER" ] || { log "mounter not found: $MOUNTER"; return 1; }
    log "rena not mounted — mounting it first"
    sh "$MOUNTER" mount >/dev/null 2>&1
    i=0
    while ! rena_healthy && [ "$i" -lt 20 ]; do sleep 1; i=$((i+1)); done
    rena_healthy || { log "rena did not come up — see /data/adb/rena/mount.log"; return 1; }
}

# ---------------------------------------------------------------------------
# Teardown: LUN -> android views -> bindfs -> raw mount -> any other mount of the loop -> detach
# ---------------------------------------------------------------------------
p_down() {
    log "--- portable down ---"
    sync
    case "$(lun_state)" in
        ours|stale) log "  clearing USB LUN"; clear_lun ;;
    esac
    for mp in $PVIS; do umount_path "$mp"; done
    umount_path "$PUV"
    umount_path "$PRAW"
    for l in $(p_loops); do                      # any mount (by anyone) still on our loops
        mm="$(cat "/sys/block/${l##*/}/dev" 2>/dev/null)"
        [ -n "$mm" ] || continue
        for mp in $(mps_by_dev "$mm" | sort -r); do
            for b in $(bindfs_on "$mp" | sort -r); do umount_path "$b"; done
            umount_path "$mp"
        done
    done
    p_detach
    dirty=0
    g_mounted "$PUV"  && { log "  STILL MOUNTED: $PUV";  dirty=1; }
    g_mounted "$PRAW" && { log "  STILL MOUNTED: $PRAW"; dirty=1; }
    [ -n "$(p_loops)" ] && { log "  STILL ATTACHED: $(p_loops | tr '\n' ' ')"; dirty=1; }
    [ "$(lun_state)" = ours ] && { log "  LUN STILL SET"; dirty=1; }
    if [ "$dirty" -eq 0 ]; then log "portable: CLEAN"; return 0; fi
    log "portable: DIRTY"; return 1
}

pfail() { log "FAILED: $*"; p_down; return 1; }

# ---------------------------------------------------------------------------
# Apply modes
# ---------------------------------------------------------------------------
check_image() {
    [ -f "$PIMG" ] || { log "image not found: $PIMG   (run: $0 create)"; return 1; }
    [ -s "$PIMG" ] || { log "image is empty: $PIMG"; return 1; }
    return 0
}

check_fstype() {
    t="$("$BLKID" -o value -s TYPE "$P_LOOP" 2>/dev/null)"
    [ "$t" = f2fs ] || { log "inner filesystem is '${t:-none}', expected f2fs (not formatted? run: $0 create)"; return 1; }
}

do_usb() {
    ro="$1"
    rena_healthy || { log "rena not healthy — cannot export"; return 1; }
    [ -x "$NSENTER" ] || { log "nsenter missing"; return 1; }
    [ -e "$UDC_PATH" ] || { log "no USB gadget at ${UDC_PATH%/UDC} — Android USB HAL not up yet?"; return 1; }
    check_image || return 1
    [ "$(lun_state)" = foreign ] && { log "LUN is used by another image (rena.img exported raw?) — refusing"; return 1; }
    file_is_f2fs "$PIMG" || { log "no f2fs magic in $PIMG (not formatted? run: $0 create)"; return 1; }
    log "===== PORTABLE -> USB ($([ "$ro" = 1 ] && echo RO || echo RW)) via ${ISODRIVE:-built-in configfs} ====="
    [ -d "$LUN" ] || log "mass_storage.0 function missing — it will be (re)created by the export"
    p_down || { log "could not reach a clean slate"; return 1; }
    udc_active || { rebind_udc; sleep 1; }
    udc_active || { pfail "UDC unbound after rebind"; return 1; }
    sync
    export_file "$PIMG" "$ro" || { pfail "export failed (LUN file is '$(lun_file)', wanted '$PIMG')"; return 1; }
    udc_active || { rebind_udc; sleep 1; }
    udc_active || { pfail "UDC unbound after export"; return 1; }
    usb_connected || log "note: no USB cable connected right now (drive appears when plugged in)"
    log "===== PORTABLE ACTIVE over USB: $PIMG ====="
}

do_system() {
    rena_healthy || { log "rena not healthy — cannot mount"; return 1; }
    [ -x "$LOSETUP" ] && [ -x "$NSENTER" ] && [ -x "$BINDFS" ] || { log "losetup/nsenter/bindfs missing"; return 1; }
    check_image || return 1
    log "===== PORTABLE -> SYSTEM ($PUV) ====="
    p_down || { log "could not reach a clean slate"; return 1; }
    p_attach || { pfail "losetup failed"; return 1; }
    check_fstype || { pfail "bad image"; return 1; }
    mkdir -p "$PRAW" "$RM/$PNAME"

    if ! try g_run mount -t f2fs -o rw,noatime "$P_LOOP" "$PRAW"; then
        log "  mount failed — running fsck once"
        if [ -n "$FSCK_F2FS" ] && [ -x "$FSCK_F2FS" ]; then
            try "$FSCK_F2FS" $FSCK_OPTS "$P_LOOP"
            try g_run mount -t f2fs -o rw,noatime "$P_LOOP" "$PRAW" || { pfail "f2fs mount failed after fsck"; return 1; }
        else
            pfail "f2fs mount failed and no fsck.f2fs found"; return 1
        fi
    fi
    g_mounted "$PRAW" || { pfail "f2fs not visible after mount"; return 1; }
    : > "$PRAW/.p_rw_test" 2>/dev/null && rm -f "$PRAW/.p_rw_test" || { pfail "write test failed"; return 1; }

    log "bindfs $PRAW -> $PUV"
    try g_run env PATH="$PATH" LD_LIBRARY_PATH="${LD_LIBRARY_PATH:-}" \
        "$BINDFS" -u "$BIND_UID" -g "$BIND_GID" --perms="$BIND_PERMS" \
        --create-with-perms=g+s "$PRAW" "$PUV"
    g_mounted "$PUV" || { pfail "bindfs failed"; return 1; }

    i=0
    while [ "$i" -lt 15 ]; do
        a="$(stat -c '%u:%g:%a:%F' "$PUV" 2>/dev/null)"
        b="$(stat -c '%u:%g:%a:%F' "$PUB/$PNAME" 2>/dev/null)"
        [ -n "$b" ] && [ "$a" = "$b" ] && { log "Android public view accessible"; break; }
        sleep 1; i=$((i+1))
    done
    [ "$i" -ge 15 ] && log "WARNING: $PUB/$PNAME not visible to Android yet (mount itself is fine; submount propagation?)"
    log "===== PORTABLE READY: $PUV ====="
}

# idempotent: avoids USB flapping when restore and a manual command race
state_ok() {
    case "$1" in
        usb)    [ "$(lun_state)" = ours ] && ! g_mounted "$PRAW" && ! g_mounted "$PUV" ;;
        system) g_mounted "$PRAW" && g_mounted "$PUV" && [ "$(lun_state)" != ours ] ;;
        off)    [ -z "$(p_loops)" ] && [ "$(lun_state)" != ours ] && ! g_mounted "$PRAW" ;;
    esac
}

do_apply() {   # $1 = mode, $2 = force(1)
    mode="$1"; force="$2"
    if [ "$force" != 1 ] && state_ok "$mode"; then log "portable already in '$mode' — nothing to do"; return 0; fi
    ro="$(cat "$ROFILE" 2>/dev/null)"; [ "$ro" = 1 ] || ro=0
    case "$mode" in
        usb)    do_usb "$ro" ;;
        system) do_system ;;
        off)    p_down ;;
    esac
}

# ---------------------------------------------------------------------------
# create
# ---------------------------------------------------------------------------
size_kb() {
    case "$1" in
        *[Gg]) echo $(( ${1%[Gg]} * 1024 * 1024 )) ;;
        *[Mm]) echo $(( ${1%[Mm]} * 1024 )) ;;
        *)     echo $(( $1 / 1024 )) ;;
    esac
}

# loops attached to the half-built image (never matches the real image: different basename)
part_loops() {
    for f in /sys/block/loop*/loop/backing_file; do
        [ -r "$f" ] || continue
        case "$(cat "$f" 2>/dev/null)" in
            *"/$PNAME.img.part"|*"/$PNAME.img.part (deleted)")
                echo "/dev/block/$(basename "$(dirname "$(dirname "$f")")")" ;;
        esac
    done
}
part_cleanup() {
    for l in $(part_loops); do "$LOSETUP" -d "$l" >/dev/null 2>&1; done
    sleep 1
    [ -z "$(part_loops)" ] && rm -f "$PIMG.part"
}

# NON-DESTRUCTIVE by construction:
#   * refuses if anything (file, dir, symlink) already exists at $PIMG
#   * never calls p_down, never touches the LUN, never touches a running portable/rena stack
#   * builds in $PIMG.part and only renames it into place (mv -n = no clobber) after a
#     successful mkfs + f2fs verification; any failure/Ctrl-C removes just the .part
#   * mkfs only ever runs on a loop whose backing file is verified to be the .part file
do_create() {
    size="$1"; PART="$PIMG.part"
    if [ -e "$PIMG" ] || [ -L "$PIMG" ]; then
        log "refusing: $PIMG already exists — nothing was changed"
        return 1
    fi
    [ -n "$MKFS_F2FS" ] && [ -x "$MKFS_F2FS" ] || { log "no mkfs.f2fs/make_f2fs found (Termux or /system/bin) — set MKFS_F2FS= in the config, see: ls /system/bin | grep f2fs"; return 1; }
    [ -x "$LOSETUP" ]   || { log "losetup missing: $LOSETUP"; return 1; }
    rena_healthy || { log "rena not healthy"; return 1; }
    case "$size" in
        [0-9]*[GgMm]) ;;
        *) log "bad size '$size' (examples: 8G, 512M)"; return 1 ;;
    esac
    need="$(size_kb "$size")"
    avail="$(df -k "$RM" 2>/dev/null | tail -n 1 | awk '{print $(NF-2)}')"
    case "$avail" in ''|*[!0-9]*) log "cannot determine free space of $RM"; return 1 ;; esac
    if [ "$avail" -le $((need + 262144)) ]; then
        log "not enough space in rena: need ${need}K (+256M slack), have ${avail}K"; return 1
    fi

    # leftover from an earlier interrupted create: it never became the real image, safe to drop
    if [ -e "$PART" ] || [ -n "$(part_loops)" ]; then
        log "discarding leftover incomplete $PART"
        part_cleanup
        [ -e "$PART" ] && { log "could not remove $PART"; return 1; }
    fi

    log "===== CREATE $PIMG ($size) via $PART ====="
    trap 'log "interrupted — removing partial image"; part_cleanup; p_unlock; exit 130' INT TERM HUP

    if command -v fallocate >/dev/null 2>&1; then
        try fallocate -l "$size" "$PART" || { part_cleanup; trap - INT TERM HUP; log "fallocate failed"; return 1; }
    elif [ -x "$T/fallocate" ]; then
        try "$T/fallocate" -l "$size" "$PART" || { part_cleanup; trap - INT TERM HUP; log "fallocate failed"; return 1; }
    else
        log "fallocate not found — creating SPARSE image (can ENOSPC later; pkg install util-linux)"
        try truncate -s "$size" "$PART" || { part_cleanup; trap - INT TERM HUP; return 1; }
    fi

    # Format the FILE directly (no loop): on this device every mkfs through a loop device fails
    # with "Failed to initialise the SIT AREA". -w 4096 gives the fs a 4096 sector size so it
    # matches the --sector-size 4096 loop used by usb/system modes. -t 0 = no discard.
    log "formatting $PART directly (make_f2fs -w 4096, no loop)"
    if ! try "$MKFS_F2FS" -f -t 0 -w 4096 -l "$PLABEL" "$PART"; then
        part_cleanup; trap - INT TERM HUP; log "mkfs.f2fs failed — partial image removed, nothing else touched"; return 1
    fi
    sync
    # verify exactly the way usb/system will use it: 4096 sector loop + direct-io
    p_attach "$PART" || { part_cleanup; trap - INT TERM HUP; log "verify: losetup failed — partial image removed"; return 1; }
    bf="$(cat "/sys/block/${P_LOOP##*/}/loop/backing_file" 2>/dev/null)"
    case "$bf" in
        *"/$PNAME.img.part") ;;
        *) part_cleanup; trap - INT TERM HUP; log "safety stop: $P_LOOP backed by '$bf' — aborted"; return 1 ;;
    esac
    t="$("$BLKID" -o value -s TYPE "$P_LOOP" 2>/dev/null)"
    if [ "$t" != f2fs ]; then
        part_cleanup; trap - INT TERM HUP; log "verification failed (fs type '${t:-none}') — partial image removed"; return 1
    fi

    "$LOSETUP" -d "$P_LOOP" >/dev/null 2>&1
    sleep 1
    sync
    if [ -n "$(part_loops)" ]; then
        part_cleanup; trap - INT TERM HUP; log "could not detach verify loop — aborted, partial image removed"; return 1
    fi
    if [ -e "$PIMG" ] || [ -L "$PIMG" ]; then
        trap - INT TERM HUP
        log "$PIMG appeared while building — NOT overwriting; finished image left at $PART"
        return 1
    fi
    mv -n "$PART" "$PIMG" 2>/dev/null
    trap - INT TERM HUP
    if [ -f "$PIMG" ] && [ ! -e "$PART" ]; then
        log "===== CREATED $PIMG. Next: $0 usb   or   $0 system ====="
        return 0
    fi
    log "rename failed — finished image left at $PART (nothing was overwritten)"
    return 1
}

# ---------------------------------------------------------------------------
# Status / fix
# ---------------------------------------------------------------------------
get_mode() { m="$(cat "$MODEFILE" 2>/dev/null)"; case "$m" in usb|system|off) echo "$m" ;; *) echo "$DEFAULT_MODE" ;; esac; }

show_status() {
    echo "desired  : $(get_mode)   ro: $(cat "$ROFILE" 2>/dev/null || echo 0)"
    echo "rena     : $(rena_healthy && echo healthy || echo DOWN)"
    echo "image    : $([ -f "$PIMG" ] && echo "$PIMG" || echo missing)"
    echo "loops    : $(p_loops | tr '\n' ' ')"
    echo "LUN      : $(lun_state)  ($(lun_file))"
    echo "raw mnt  : $(g_mounted "$PRAW" && echo "$PRAW" || echo -)"
    echo "bindfs   : $(g_mounted "$PUV" && echo "$PUV" || echo -)"
    echo "USB link : $(usb_connected && echo connected || echo 'not connected')"
    nl="$(p_loops | wc -l)"
    [ "$nl" -gt 1 ] && echo "PROBLEM  : $nl loops on the same image — run: $0 fix"
    if [ "$(lun_state)" = ours ] && g_mounted "$PRAW"; then
        echo "PROBLEM  : exported AND mounted locally (corruption risk) — run: $0 fix"
    fi
    if [ -n "$(p_loops)" ] && [ "$(lun_state)" != ours ] && ! g_mounted "$PRAW"; then
        echo "PROBLEM  : loop attached but unused — run: $0 fix"
    fi
    rena_healthy || { [ "$(get_mode)" != off ] && echo "NOTE     : rena is down; portable will re-apply '$(get_mode)' when it is mounted"; }
}

do_fix() {
    log "===== FIX ====="
    show_status | while IFS= read -r l; do log "  $l"; done
    p_down || log "warning: could not fully clean"
}

# ---------------------------------------------------------------------------
# Command wrappers
# ---------------------------------------------------------------------------
set_mode_and_apply() {   # $1 mode
    printf '%s\n' "$1" > "$MODEFILE"                 # intent first: survives failure/reboot
    if [ "$1" != off ]; then
        ensure_rena || { log "mode '$1' recorded; will apply once rena is mounted"; return 1; }
    fi
    locked do_apply "$1" 0
}

cmd_restore() {
    mode="$(get_mode)"
    [ "$mode" = off ] && return 0
    [ -f "$PIMG" ] || { log "restore: no image yet (run: $0 create)"; return 0; }
    rena_healthy || { log "restore: rena not healthy — skipping"; return 0; }
    if [ "$mode" = usb ]; then
        i=0; while [ ! -e "$UDC_PATH" ] && [ "$i" -lt 60 ]; do sleep 1; i=$((i+1)); done
    fi
    log "restore: applying '$mode'"
    locked do_apply "$mode" 0
}

# parse flags from the remaining args
parse_flags() {
    for a in "$@"; do
        case "$a" in
            --ro)       echo 1 > "$ROFILE" ;;
            --rw)       echo 0 > "$ROFILE" ;;
            --takeover) TAKEOVER=1 ;;
        esac
    done
}

cmd="$1"; [ $# -gt 0 ] && shift
case "$cmd" in
    usb)       parse_flags "$@"; set_mode_and_apply usb ;;
    system)    parse_flags "$@"; set_mode_and_apply system ;;
    off)       set_mode_and_apply off ;;
    toggle)    parse_flags "$@"; if [ "$(get_mode)" = usb ]; then set_mode_and_apply system; else set_mode_and_apply usb; fi ;;
    create)    parse_flags "$@"; sz="$1"; case "$sz" in --*) sz="" ;; esac
               ensure_rena && locked do_create "${sz:-$PSIZE}" ;;
    status)    show_status ;;
    fix)       parse_flags "$@"
               locked do_fix
               m="$(get_mode)"
               if [ "$m" != off ]; then ensure_rena && locked do_apply "$m" 1; fi ;;
    restore)   cmd_restore ;;
    down-hook) locked_soft p_down >/dev/null 2>&1; exit 0 ;;
    *)         sed -n '2,/^$/p' "$0" | sed 's/^# \{0,1\}//'; exit 1 ;;
esac
