#!/system/bin/sh
# rena-mount.sh — /data/adb/service.d/ script
#
# Mounts a LUKS2 + F2FS image that lives on an SD card, imgdrive-style:
#   SD partition -> /mnt/sd -> loop -> LUKS -> f2fs -> bindfs (Android-visible)
#
#   * verifies the SD card is the expected one (filesystem UUID)
#   * if the matching card is mounted by vold / another mounter, unmounts that
#   * releases any other loop/mapper/mounts holding the same image
#   * wipes every leftover before mounting, verifies it is clean
#   * boot-time mount + inotify watcher: remount on reinsertion, clean on removal
#   * watchdog (every 20s): removes foreign mounts of the card, self-heals
#
# Usage (as root):
#   rena-mount.sh            start the background daemon (what service.d does)
#   rena-mount.sh pin        remember the inserted card's UUID (no script editing)
#   rena-mount.sh mount      clean + mount now (also un-pauses the daemon)
#   rena-mount.sh umount     clean everything now (pauses daemon until next 'mount')
#   rena-mount.sh status
#   rena-mount.sh release-card   evict vold/other mounters from the card (used by rena-iso.sh)
#   rena-mount.sh selftest       make Android mount the card on purpose, then evict it, verbosely
#
# Log: /data/adb/rena/mount.log

# ============================ CONFIG ========================================
SD_DEV="/dev/block/mmcblk1p1"
SD_UUID=""                      # leave empty and run 'pin', or paste blkid's UUID here
SD_MNT="/mnt/sd"
IMG_REL="rena.img"              # path of the image relative to the SD root
KEY="/data/media/0/Documents/luks_keys/catherine"   # raw path, not via FUSE /sdcard
LUKS_UUID=""                    # optional: cryptsetup luksUUID of the image (empty = skip)

NAME="rena"                     # /dev/mapper/<NAME>
RM="/mnt/media_rw/$NAME"        # raw f2fs mount point
UV="/data/media/0/$NAME"        # bindfs mount point (what Android sees)
PUB="/storage/emulated/0/$NAME"
BIND_UID=1023
BIND_GID=1023
BIND_PERMS=0770

SETTLE=5                        # seconds to wait after Android finished mounting the card, before evicting it
WATCHDOG=20                     # seconds between health checks
HEAL_COOLDOWN=120               # min seconds between automatic re-mount attempts

T="/data/data/com.termux/files/usr/bin"
CRYPTSETUP="$T/cryptsetup"
LOSETUP="$T/losetup"
BINDFS="$T/bindfs"
NSENTER="$T/nsenter"
INOTIFY="$T/inotifywait"
BLKID="/system/bin/blkid"

STATE_DIR="/data/adb/rena"
# ============================================================================

mkdir -p "$STATE_DIR"
[ -z "$SD_UUID" ] && [ -r "$STATE_DIR/sd.uuid" ] && SD_UUID="$(cat "$STATE_DIR/sd.uuid")"

IMG="$SD_MNT/$IMG_REL"
IMG_NAME="$(basename "$IMG_REL")"
SD_NAME="$(basename "$SD_DEV")"
LOGFILE="$STATE_DIR/mount.log"
PIDFILE="$STATE_DIR/daemon.pid"
LOCKDIR="$STATE_DIR/lock"
PAUSEFILE="$STATE_DIR/paused"
LOOP=""

log() { printf '%s %s\n' "$(date '+%m-%d %H:%M:%S')" "$*" >> "$LOGFILE" 2>/dev/null; [ -t 1 ] && printf '%s\n' "$*"; return 0; }

# Daemonize when launched by service.d (the root manager may wait on the script)
if [ $# -eq 0 ]; then
    sh "$0" --daemon </dev/null >/dev/null 2>&1 &
    exit 0
fi

# ---------------------------------------------------------------------------
# Global (PID 1) mount namespace helpers
# ---------------------------------------------------------------------------
g_run()    { "$NSENTER" -t 1 -m -- "$@"; }
g_mount()  { g_run mount "$@"; }
g_umount() { g_run umount "$@"; }
mi()       { g_run cat /proc/self/mountinfo 2>/dev/null; }
g_mounted() { mi | awk -v t="$1" '$5==t{f=1} END{exit !f}'; }
# mount points whose backing device is major:minor $1
mps_by_dev() { mi | awk -v m="$1" '$3==m{print $5}'; }
# fuse (bindfs etc.) mounts whose source is the path $1
bindfs_on() {
    mi | awk -v s="$1" '{for(i=7;i<=NF;i++) if($i=="-"){ if($(i+1) ~ /^fuse/ && $(i+2)==s) print $5; break }}'
}

# ---------------------------------------------------------------------------
# Lock (serialises daemon, watcher, watchdog and manual runs)
# ---------------------------------------------------------------------------
acquire_lock() {
    n=0
    while ! mkdir "$LOCKDIR" 2>/dev/null; do
        p="$(cat "$LOCKDIR/pid" 2>/dev/null)"
        if [ -n "$p" ] && ! kill -0 "$p" 2>/dev/null; then rm -rf "$LOCKDIR"; continue; fi
        n=$((n+1)); [ "$n" -gt 90 ] && return 1
        sleep 1
    done
    echo $$ > "$LOCKDIR/pid"
}
release_lock() { rm -rf "$LOCKDIR"; }
locked() {
    acquire_lock || { log "could not get lock"; return 1; }
    "$@"; _rc=$?
    release_lock
    return $_rc
}

# ---------------------------------------------------------------------------
# Cleanup
# ---------------------------------------------------------------------------
umount_path() {
    i=0
    while g_mounted "$1" && [ "$i" -lt 6 ]; do
        log "  umount $1"
        g_umount "$1" >/dev/null 2>&1 || g_umount -l "$1" >/dev/null 2>&1
        i=$((i+1))
    done
}

# unmount every mount backed by device major:minor $1 (plus bindfs layers on top)
release_dev_mounts() {
    for mp in $(mps_by_dev "$1" | sort -r); do
        for b in $(bindfs_on "$mp" | sort -r); do umount_path "$b"; done
        umount_path "$mp"
    done
}

mapper_active() { "$CRYPTSETUP" status "$NAME" >/dev/null 2>&1; }

close_mapper() {
    mapper_active || return 0
    log "  luksClose $NAME"
    "$CRYPTSETUP" luksClose "$NAME" >/dev/null 2>&1 && return 0
    sleep 1
    "$CRYPTSETUP" luksClose "$NAME" >/dev/null 2>&1 && return 0
    log "  luksClose failed, trying --deferred"
    "$CRYPTSETUP" close --deferred "$NAME" >/dev/null 2>&1
    sleep 1
    mapper_active && return 1
    return 0
}

image_loops() {
    for f in /sys/block/loop*/loop/backing_file; do
        [ -r "$f" ] || continue
        b="$(cat "$f" 2>/dev/null)"
        case "$b" in
            *"/$IMG_NAME"|*"/$IMG_NAME (deleted)")
                echo "/dev/block/$(basename "$(dirname "$(dirname "$f")")")" ;;
        esac
    done
}

# Any dm device (any name, e.g. from another mounter) sitting on our image's loops
release_loop_holders() {
    for l in $(image_loops); do
        lb="$(basename "$l")"
        for h in /sys/block/"$lb"/holders/*; do
            [ -d "$h" ] || continue
            dmname="$(cat "$h/dm/name" 2>/dev/null)"
            mm="$(cat "$h/dev" 2>/dev/null)"
            log "  loop $lb is held by dm '$dmname' ($mm)"
            [ -n "$mm" ] && release_dev_mounts "$mm"
            if [ -n "$dmname" ] && [ "$dmname" != "$NAME" ]; then
                "$CRYPTSETUP" luksClose "$dmname" >/dev/null 2>&1 \
                    || "$CRYPTSETUP" close --deferred "$dmname" >/dev/null 2>&1
            fi
        done
    done
}

detach_loops() {
    for l in $(image_loops); do
        log "  detach $l"
        "$LOSETUP" -d "$l" >/dev/null 2>&1
    done
    [ -z "$(image_loops)" ]
}

# run a command; on failure put its output (stdout+stderr) in the log
try() {
    _out="$("$@" 2>&1)"; _rc=$?
    if [ "$_rc" -ne 0 ]; then
        log "    '$1' failed (rc=$_rc)"
        [ -n "$_out" ] && printf '%s\n' "$_out" | while IFS= read -r _l; do log "      $_l"; done
    fi
    return "$_rc"
}

# Ask vold/StorageManager to eject the card properly (tears down /storage/<UUID>,
# the fuse/sdcardfs layers and the framework state), instead of raw umounts.
vold_unmount() {
    [ -n "$SD_UUID" ] || return 0
    ids=""; via=sm
    if command -v sm >/dev/null 2>&1; then
        ids="$(sm list-volumes 2>/dev/null | awk -v u="$SD_UUID" 'toupper($0) ~ toupper(u) && $2!="unmounted" {print $1}')"
    fi
    if [ -z "$ids" ] && command -v vdc >/dev/null 2>&1; then
        # sm knows nothing (empty list) — take the volume id from the mount source
        # (/dev/block/vold/public:179,1) of whatever currently mounts our device
        via=vdc
        mm="$(cat "/sys/class/block/$SD_NAME/dev" 2>/dev/null)"
        ids="$(mi | awk -v mm="$mm" '$3==mm { for(i=7;i<=NF;i++) if($i=="-"){ src=$(i+2); n=split(src,a,"/"); if (src ~ /^\/dev\/block\/vold\//) print a[n]; break } }' | sort -u)"
    fi
    for id in $ids; do
        log "  vold has the card ($id) — $via unmount"
        if [ "$via" = vdc ]; then cmd="vdc volume unmount $id"; else cmd="sm unmount $id"; fi
        if command -v timeout >/dev/null 2>&1; then timeout 20 $cmd >/dev/null 2>&1; else $cmd >/dev/null 2>&1; fi
    done
    [ -n "$ids" ] && sleep 2
    return 0
}

# Mounts of the (UUID-verified) card made by vold or any other mounter.
# Matches by backing device major:minor, and by mount-point name == UUID
# (/storage/<UUID>, /mnt/media_rw/<UUID>, /mnt/user/0/<UUID>, ...). SD_MNT is ours — skipped.
foreign_mounts() {
    [ -n "$SD_UUID" ] || return 0
    mm="$(cat "/sys/class/block/$SD_NAME/dev" 2>/dev/null)"
    mi | awk -v mm="$mm" -v u="$SD_UUID" -v own="$SD_MNT" '
        $5==own { next }
        { n=split($5,a,"/"); b=a[n]
          if ((mm!="" && $3==mm) || toupper(b)==toupper(u)) print $5 }' | sort -r
}

# How the eviction works, in order:
#   1. vold_unmount : ask vold itself (sm/vdc) to eject the volume -> it tears down
#                     /storage/<UUID>, the fuse layer and /mnt/media_rw/<UUID> cleanly
#   2. raw umount   : every mount still backed by the card (same major:minor) or named
#                     after its UUID, bindfs layers first; plain umount, then umount -l
#   3. verify       : re-read mountinfo, log anything that is STILL there
unmount_foreign() {
    [ -n "$SD_UUID" ] || return 0
    vold_unmount
    list="$(foreign_mounts)"
    [ -n "$list" ] || return 0
    for mp in $list; do
        log "  card is mounted elsewhere: $mp — unmounting"
        for b in $(bindfs_on "$mp" | sort -r); do umount_path "$b"; done
        umount_path "$mp"
    done
    left="$(foreign_mounts)"
    if [ -n "$left" ]; then
        for mp in $left; do log "  STILL HELD BY ANDROID: $mp"; done
        return 1
    fi
    log "  card released (no foreign mounts left)"
    return 0
}

cleanup_all() {
    log "--- cleanup ---"
    for mp in \
        "$PUB" \
        "/mnt/androidwritable/0/emulated/0/$NAME" \
        "/mnt/installer/0/emulated/0/$NAME" \
        "/mnt/user/0/emulated/0/$NAME" \
        "/mnt/pass_through/0/emulated/0/$NAME" \
        "$UV" "$RM"; do
        umount_path "$mp"
    done
    release_loop_holders
    close_mapper
    detach_loops
    umount_path "$SD_MNT"

    dirty=0
    for mp in "$UV" "$PUB" "$RM" "$SD_MNT"; do
        g_mounted "$mp" && { log "  STILL MOUNTED: $mp"; dirty=1; }
    done
    mapper_active && { log "  STILL ACTIVE: /dev/mapper/$NAME"; dirty=1; }
    [ -n "$(image_loops)" ] && { log "  STILL ATTACHED: $(image_loops | tr '\n' ' ')"; dirty=1; }
    if [ "$dirty" -eq 0 ]; then log "cleanup: CLEAN"; else log "cleanup: DIRTY"; return 1; fi
}

# ---------------------------------------------------------------------------
# SD card identity
#   rc 0 = expected card   2 = no block device   3 = not readable yet
#   rc 4 = wrong card / UUID not configured
# ---------------------------------------------------------------------------
sd_check() {
    [ -b "$SD_DEV" ] || return 2
    uuid="$("$BLKID" -o value -s UUID "$SD_DEV" 2>/dev/null)"
    [ -n "$uuid" ] || return 3
    if [ -z "$SD_UUID" ]; then
        log "no card UUID configured — detected $uuid on $SD_DEV; run: sh $0 pin"
        return 4
    fi
    if [ "$uuid" != "$SD_UUID" ]; then
        log "WRONG CARD: UUID $uuid (expected $SD_UUID) — not touching it"
        return 4
    fi
    return 0
}

wait_sd_ready() {
    i=0
    while [ "$i" -lt 30 ]; do
        sd_check; rc=$?
        case "$rc" in 0|4) return $rc ;; esac
        sleep 1; i=$((i+1))
    done
    return "$rc"
}

# ---------------------------------------------------------------------------
# Mount
# ---------------------------------------------------------------------------
fail() { log "FAILED: $*"; cleanup_all; return 1; }

do_mount() {
    log "===== mount: $NAME ====="
    sd_check; rc=$?
    case "$rc" in
        0) ;;
        4) return 4 ;;
        *) log "SD card not present/readable (rc=$rc)"; return "$rc" ;;
    esac
    log "SD UUID ok ($SD_UUID)"

    unmount_foreign
    cleanup_all || { log "cleanup incomplete — aborting"; return 1; }

    [ -r "$KEY" ] || { log "keyfile not readable: $KEY"; return 1; }
    mkdir -p "$SD_MNT" "$RM" "$UV"

    log "mounting $SD_DEV -> $SD_MNT"
    k=1
    while ! try g_mount "$SD_DEV" "$SD_MNT"; do
        # most likely vold grabbed the card again (shared superblock, different options -> EBUSY)
        log "  SD mount try $k failed — evicting vold/other mounters and retrying"
        dmesg 2>/dev/null | tail -n 40 | grep -iE 'exfat|fat|sdfat|mmc|mmcblk1|f2fs' | tail -n 4 | while IFS= read -r _l; do log "    dmesg: $_l"; done
        unmount_foreign
        k=$((k+1)); [ "$k" -gt 3 ] && { fail "SD mount failed"; return 1; }
        sleep 2
    done
    [ -f "$IMG" ] || { fail "image not found: $IMG"; return 1; }

    LOOP="$("$LOSETUP" -f --show --sector-size 4096 --direct-io=on "$IMG" 2>>"$LOGFILE")"
    [ -n "$LOOP" ] || { fail "losetup failed"; return 1; }
    log "loop = $LOOP"

    "$CRYPTSETUP" isLuks "$LOOP" >/dev/null 2>&1 || { fail "not a LUKS image (or wrong sector size)"; return 1; }
    if [ -n "$LUKS_UUID" ]; then
        got="$("$CRYPTSETUP" luksUUID "$LOOP" 2>/dev/null)"
        [ "$got" = "$LUKS_UUID" ] || { fail "LUKS UUID mismatch ($got)"; return 1; }
    fi

    try "$CRYPTSETUP" luksOpen "$LOOP" "$NAME" --key-file "$KEY"   # chown warning is harmless
    mapper_active || { fail "luksOpen failed"; return 1; }
    log "LUKS mapper active"

    fstype="$("$BLKID" -o value -s TYPE "/dev/mapper/$NAME" 2>/dev/null)"
    [ -n "$fstype" ] || { fail "cannot detect inner filesystem"; return 1; }
    log "inner fs = $fstype"
    try g_mount -t "$fstype" -o rw "/dev/mapper/$NAME" "$RM" || { fail "$fstype mount failed"; return 1; }
    g_mounted "$RM" || { fail "$fstype not visible after mount"; return 1; }
    : > "$RM/.rena_rw_test" 2>/dev/null && rm -f "$RM/.rena_rw_test" || { fail "write test failed"; return 1; }

    log "bindfs $RM -> $UV"
    try g_run env PATH="$PATH" LD_LIBRARY_PATH="${LD_LIBRARY_PATH:-}" \
        "$BINDFS" -u "$BIND_UID" -g "$BIND_GID" --perms="$BIND_PERMS" \
        --create-with-perms=g+s "$RM" "$UV"
    g_mounted "$UV" || { fail "bindfs failed"; return 1; }

    i=0
    while [ "$i" -lt 15 ]; do
        a="$(stat -c '%u:%g:%a:%F' "$UV" 2>/dev/null)"
        b="$(stat -c '%u:%g:%a:%F' "$PUB" 2>/dev/null)"
        [ -n "$b" ] && [ "$a" = "$b" ] && { log "Android public view accessible"; break; }
        sleep 1; i=$((i+1))
    done
    [ "$i" -ge 15 ] && log "WARNING: $PUB not visible yet (mount itself is fine)"

    log "===== READY: $UV ====="
    return 0
}

# Does anything other than our own SD_MNT currently mount the card? (vold = yes)
vold_holds() {
    mm="$(cat "/sys/class/block/$SD_NAME/dev" 2>/dev/null)"
    [ -n "$mm" ] || return 1
    mi | awk -v mm="$mm" -v own="$SD_MNT" '$5!=own && $3==mm {f=1} END{exit !f}'
}

# Android mounts the card on its own (at boot / insertion) and usually wins the race.
# Let it finish first, so our eviction runs AFTER it and is not undone by it.
wait_vold() {
    i=0
    while [ "$i" -lt 30 ]; do
        if vold_holds; then
            log "Android mounted the card — letting it finish (${SETTLE}s), then evicting it"
            sleep "$SETTLE"
            return 0
        fi
        sleep 1; i=$((i+1))
    done
    log "Android did not mount the card within 30s — continuing"
}

mount_with_retries() {
    wait_sd_ready; rc=$?
    if [ "$rc" -ne 0 ]; then
        log "card not usable (rc=$rc) — not mounting"
        return 1
    fi
    [ "$1" = settle ] && wait_vold
    n=1
    while [ "$n" -le 5 ]; do
        locked do_mount && return 0
        sd_check || { log "card gone/changed — stopping retries"; return 1; }
        log "mount attempt $n failed — retry in 8s"
        n=$((n+1)); sleep 8
    done
    log "giving up after 5 attempts"
    return 1
}

healthy() { mapper_active && g_mounted "$RM" && g_mounted "$UV"; }

# Runs under the lock every WATCHDOG seconds
heal() {
    [ -f "$PAUSEFILE" ] && return 0
    sd_check || return 0
    unmount_foreign
    healthy && return 0
    log "watchdog: stack unhealthy — remounting"
    do_mount
}

# ---------------------------------------------------------------------------
# Status
# ---------------------------------------------------------------------------
show_status() {
    sd_check; echo "sd_check rc=$? (0 = expected card)"
    echo "SD_UUID : ${SD_UUID:-<not set>}"
    for mp in "$SD_MNT" "$RM" "$UV"; do
        g_mounted "$mp" && echo "mounted : $mp" || echo "-       : $mp"
    done
    mapper_active && echo "mapper  : active" || echo "mapper  : -"
    echo "loops   : $(image_loops | tr '\n' ' ')"
    [ -f "$PAUSEFILE" ] && echo "paused  : yes (run 'mount' to resume)"
    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        echo "daemon  : running ($(cat "$PIDFILE"))"
    else
        echo "daemon  : not running"
    fi
}

# ---------------------------------------------------------------------------
# Daemon
# ---------------------------------------------------------------------------
watchdog_loop() {
    last_heal=0; tick=0
    every=$((WATCHDOG / 5)); [ "$every" -ge 1 ] || every=1
    ss_prev="$(pidof system_server 2>/dev/null)"
    while true; do
        sleep 5
        tick=$((tick+1))
        # stop;start / framework crash => new system_server => vold resets and
        # re-mounts the card as a normal sdcard. React immediately, not at the next tick.
        ss="$(pidof system_server 2>/dev/null)"
        if [ -n "$ss" ] && [ -n "$ss_prev" ] && [ "$ss" != "$ss_prev" ]; then
            ss_prev="$ss"
            if [ ! -f "$PAUSEFILE" ] && [ -b "$SD_DEV" ]; then
                log "watchdog: system_server restarted (stop;start / framework restart) — re-checking"
                sleep 3
                wait_vold
                locked heal
            fi
            continue
        fi
        [ -n "$ss" ] && ss_prev="$ss"

        [ $((tick % every)) -eq 0 ] || continue
        now="$(date +%s)"
        # cheap pre-check outside the lock; heal() re-checks inside it
        [ -f "$PAUSEFILE" ] && continue
        [ -b "$SD_DEV" ] || continue
        if healthy; then
            locked unmount_foreign_if_card
        elif [ $((now - last_heal)) -ge "$HEAL_COOLDOWN" ]; then
            last_heal="$now"
            locked heal
        fi
    done
}
unmount_foreign_if_card() { sd_check && unmount_foreign; }
release_card() { sd_check && unmount_foreign; }

# Reproduce "Android grabbed the card" on demand and show how the eviction copes.
selftest() {
    echo "== BEFORE =="; show_status
    sd_check || { echo "card check failed — pin the UUID first"; return 1; }
    if vold_holds; then
        echo "Android already holds the card."
    else
        id="public:$(cat "/sys/class/block/$SD_NAME/dev" 2>/dev/null | tr ':' ',')"
        echo "asking vold to mount the card: vdc volume mount $id 0 0"
        vdc volume mount "$id" 0 0 2>&1 | sed 's/^/  vdc> /'
        i=0; while [ "$i" -lt 20 ] && ! vold_holds; do sleep 1; i=$((i+1)); done
        vold_holds || { echo "vold did not mount it within 20s (try: sm list-volumes, logcat | grep vold)"; return 1; }
        sleep "$SETTLE"
    fi
    echo "== FOREIGN MOUNTS OF THE CARD =="; foreign_mounts | sed 's/^/  /'
    echo "== EVICTING (what the daemon does) =="
    locked release_card; rc=$?
    echo "== AFTER (eviction rc=$rc) =="
    echo "foreign mounts left:"; foreign_mounts | sed 's/^/  /'
    show_status
    if healthy; then echo "RESULT: our stack is healthy"
    else echo "RESULT: our stack is DOWN — daemon/watchdog (or 'mount') would rebuild it"; fi
}


daemon() {
    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then exit 0; fi
    echo $$ > "$PIDFILE"
    if [ -f "$LOGFILE" ]; then tmp="$(tail -n 300 "$LOGFILE")"; printf '%s\n' "$tmp" > "$LOGFILE"; fi
    log "===== rena-mount daemon start (pid $$) ====="
    rm -f "$PAUSEFILE"

    # boot gates: framework up, then keyfile readable
    while [ "$(getprop sys.boot_completed)" != "1" ]; do sleep 3; done
    i=0
    while [ ! -r "$KEY" ] && [ "$i" -lt 120 ]; do sleep 5; i=$((i+1)); done
    [ -r "$KEY" ] || log "WARNING: keyfile still unreadable after boot wait"

    mount_with_retries settle

    watchdog_loop &

    last_done=0
    while true; do
        if [ -x "$INOTIFY" ]; then
            log "watcher: inotifywait on /dev/block for $SD_NAME"
            "$INOTIFY" -m -q -e create -e delete --format '%e %f' /dev/block 2>/dev/null |
            while read -r ev name; do
                [ "$name" = "$SD_NAME" ] || continue
                case "$ev" in
                    *DELETE*)
                        log "watcher: $SD_NAME removed — cleaning up"
                        locked cleanup_all ;;
                    *CREATE*)
                        if [ -f "$PAUSEFILE" ]; then log "watcher: paused — ignoring"; continue; fi
                        now="$(date +%s)"
                        if [ $((now - last_done)) -lt 10 ]; then
                            log "watcher: duplicate event ignored"; continue
                        fi
                        log "watcher: $SD_NAME appeared"
                        mount_with_retries settle
                        last_done="$(date +%s)" ;;
                esac
            done
            log "watcher: inotifywait exited — restarting in 5s"
            sleep 5
        else
            log "watcher: inotifywait missing — polling every 3s"
            prev=absent; [ -b "$SD_DEV" ] && prev=present
            while true; do
                cur=absent; [ -b "$SD_DEV" ] && cur=present
                if [ "$cur" != "$prev" ]; then
                    if [ "$cur" = present ]; then
                        log "poll: $SD_NAME appeared"
                        [ -f "$PAUSEFILE" ] || mount_with_retries settle
                    else
                        log "poll: $SD_NAME removed — cleaning up"; locked cleanup_all
                    fi
                    prev="$cur"
                fi
                sleep 3
            done
        fi
    done
}

pin_uuid() {
    [ -b "$SD_DEV" ] || { echo "no card at $SD_DEV"; exit 1; }
    u="$("$BLKID" -o value -s UUID "$SD_DEV" 2>/dev/null)"
    [ -n "$u" ] || { echo "cannot read UUID of $SD_DEV"; exit 1; }
    printf '%s\n' "$u" > "$STATE_DIR/sd.uuid"
    echo "pinned card UUID: $u  (saved to $STATE_DIR/sd.uuid)"
    log "pinned SD UUID $u"
}

case "$1" in
    --daemon) daemon ;;
    pin)      pin_uuid ;;
    mount)    rm -f "$PAUSEFILE"; mount_with_retries ;;
    umount)   touch "$PAUSEFILE"; locked cleanup_all ;;
    status)   show_status ;;
    release-card) locked release_card ;;
    selftest) selftest ;;
    *)        echo "usage: $0 [pin|mount|umount|status|release-card|selftest]"; exit 1 ;;
esac
