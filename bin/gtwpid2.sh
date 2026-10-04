#!/bin/bash

# 1. Setup Paths
EXTENSION_DATA="/tmp/gnome-audio-status.json"
PW_DUMP="/tmp/pw_dump_logic.json"

if [ ! -f "$EXTENSION_DATA" ]; then
  echo "Error: $EXTENSION_DATA not found. Is the GNOME extension running?"
  exit 1
fi

# 2. Get Live Data from PipeWire
# We save a local dump to ensure we match Client IDs to PIDs accurately
pw-dump >"$PW_DUMP"

# Identify the Focused PID from the extension's JSON
FOCUSED_PID=$(jq -r '.focused.pid' "$EXTENSION_DATA")
FOCUSED_TITLE=$(jq -r '.focused.title' "$EXTENSION_DATA")

echo "------------------------------------------"
echo "CURRENT FOCUS: $FOCUSED_TITLE (PID: $FOCUSED_PID)"
echo "------------------------------------------"

# 3. Extract running audio nodes
# We use the logic from Script 1 to find nodes in "running" state
RUNNING_CLIENT_IDS=$(jq -r '.[] | select(.type == "PipeWire:Interface:Node" and .info.state == "running" and .info.props["media.class"] == "Stream/Output/Audio") | .info.props["client.id"]' "$PW_DUMP")

if [ -z "$RUNNING_CLIENT_IDS" ]; then
  echo "No active audio streams found in PipeWire."
  rm "$PW_DUMP"
  exit 0
fi

# 4. Map Client IDs to PIDs and check against Focus
IS_FOCUS_PLAYING=false
OTHER_PLAYERS=""

for CID in $RUNNING_CLIENT_IDS; do
  # Link Client ID to the actual Process ID (Technique from Script 1)
  STREAM_PID=$(jq -r ".[] | select(.id == $CID) | .info.props[\"application.process.id\"]" "$PW_DUMP")

  if [ "$STREAM_PID" == "$FOCUSED_PID" ]; then
    IS_FOCUS_PLAYING=true
  else
    # Match the PID against the extension's known window titles
    TITLE=$(jq -r ".audio_windows[] | select(.pid == $STREAM_PID) | .title" "$EXTENSION_DATA" | head -n 1)

    # Fallback if the extension doesn't see the window (e.g. background process)
    [ -z "$TITLE" ] || [ "$TITLE" == "null" ] && TITLE=$(ps -p "$STREAM_PID" -o comm= 2>/dev/null || echo "Unknown System Process")

    OTHER_PLAYERS+="  • $TITLE (PID: $STREAM_PID)\n"
  fi
done

# 5. Output Results
if [ "$IS_FOCUS_PLAYING" = true ]; then
  echo "🔊 Focused window IS playing audio."
else
  echo "🔇 Focused window is SILENT."
fi

echo -e "\n--- Other Windows Playing Audio ---"
if [ -z "$OTHER_PLAYERS" ]; then
  echo "  (None)"
else
  echo -ne "$OTHER_PLAYERS"
fi

# Cleanup
rm "$PW_DUMP"
