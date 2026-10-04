#!/bin/bash

instant_run_args="$@"

CONFIG_FILE="$HOME/.config/ssaver"

if [ ! -f "$CONFIG_FILE" ]; then
  echo hi
  # echo "ghostty --config-file=/home/rex/.config/ghostty/config.ssaver -e "/usr/bin/ghosttyboo" " >~/.config/ssaver
  cat <<'EOF' >$CONFIG_FILE
  CMD="qmatrix -d 0 -s 1.3 --tail-min 50 --tail-max 60" && echo "#!/bin/bash" >~/.local/bin/ssaver && echo "$CMD" >>~/.local/bin/ssaver && chmod +x ~/.local/bin/ssaver && ghostty --config-file=/home/rex/.config/ghostty/config.ssaver -e ssaver
EOF
  echo "copy this please, look at the ssaver.sh file"
  pip install qmatrix
fi

# Configuration
SCREENSAVER_CMD=$(cat $CONFIG_FILE | tail -n 1)
# SCREENSAVER_CMD="ghostty --config-file=/home/rex/.config/ghostty/config.ssaver -e "/usr/bin/ghosttyboo" "

# ghosttyboo contents:
# #!/bin/bash
# ghostty +boo

# config.ssaver contents:
# CMD="qmatrix -d 0 -s 1.3 --tail-min 50 --tail-max 60" && echo "#!/bin/bash" >~/.local/bin/ssaver && echo "$CMD" >>~/.local/bin/ssaver && chmod +x ~/.local/bin/ssaver && ghostty --config-file=/home/rex/.config/ghostty/config.ssaver -e ssaver

# Inactivity threshold in seconds (e.g., 600 seconds = 10 minutes)
INACTIVITY_THRESHOLD=60
INACTIVITY_THRESHOLD=$(($INACTIVITY_THRESHOLD * 1000))

# Polling interval in seconds
POLL_INTERVAL=1

## --- Helper function for Idle Time (Using GNOME Mutter D-Bus) ---

get_idle_time() {
  # 1. Call the D-Bus method to get idle time in milliseconds
  IDLE_MS=$(gdbus call \
    --session \
    --dest org.gnome.Mutter.IdleMonitor \
    --object-path /org/gnome/Mutter/IdleMonitor/Core \
    --method org.gnome.Mutter.IdleMonitor.GetIdletime 2>/dev/null)

  # 2. Extract the number using sed (More reliable than Bash regex for D-Bus output)
  # This pattern specifically extracts digits surrounded by parentheses and ignores everything else.
  IDLE_NUM=$(echo "$IDLE_MS" | awk -F "64 " '{print $2}' | awk -F "," '{print $1}')

  # 3. Check if we successfully extracted a number
  if [[ "$IDLE_NUM" =~ ^[0-9]+$ && "$IDLE_NUM" -gt 0 ]]; then
    # Convert milliseconds to seconds using integer division
    IDLE_mSECONDS=$IDLE_NUM
    echo "$IDLE_mSECONDS"
  else
    # If the call failed, returned 0, or couldn't be parsed, assume 0 (active)
    echo 0
  fi
}

## --- Helper function for Media Status (Using playerctl) ---
is_media_active() {
  # You still need playerctl for reliable media detection.
  # Install: sudo dnf install playerctl
  playerctl -a status 2>/dev/null | grep -q "Playing"

  if [ $? -eq 0 ]; then
    echo "1" # Media is active
  else
    echo "0" # No media is active
  fi
}
# ---------------------------------------------------------------------------------

## --- Main Screensaver Function ---
screen_saver() {
  $SCREENSAVER_CMD &
  CURRENT_IDLE=$(get_idle_time)
  PREVIOUS_PID=$!
  while [ "$CURRENT_IDLE" -ge 200 ]; do
    echo $CURRENT_IDLE
    sleep 0.1
    CURRENT_IDLE=$(get_idle_time)
  done
  kill $PREVIOUS_PID
}
# ---------------------------------------------------------------------------------

# Main monitoring loop
if [ -z "$SCREENSAVER_CMD" ]; then
  echo "Error: Screensaver command not provided."
  echo "Usage: $0 \"<your screensaver command>\""
  exit 1
fi

echo "--- Inactivity Detector Started ---"
echo "Method: GNOME D-Bus IdleMonitor + playerctl"
echo "Threshold: ${INACTIVITY_THRESHOLD}s"
echo "Screensaver Command: $SCREENSAVER_CMD"
echo "-----------------------------------"

if [ "$instant_run_args" == "runnow" ]; then
  echo "Running screensaver now..."
  screen_saver
  exit
fi

while true; do
  CURRENT_IDLE=$(get_idle_time)
  MEDIA_ACTIVE=$(is_media_active)
  echo $CURRENT_IDLE
  echo $MEDIA_ACTIVE

  if [ "$MEDIA_ACTIVE" == "1" ]; then
    echo "$(date +%T) -> Media is **ACTIVE**. Idle time is ignored."
  elif [ "$CURRENT_IDLE" -ge "$INACTIVITY_THRESHOLD" ]; then
    echo "$(date +%T) -> Idle time (${CURRENT_IDLE}s) exceeded threshold. **TRIGGERING screensaver.**"
    screen_saver
    # sleep 5
  else
    echo "$(date +%T) -> Idle time: ${CURRENT_IDLE}s (Threshold: ${INACTIVITY_THRESHOLD}s). Monitoring..."
  fi

  sleep $POLL_INTERVAL
done
