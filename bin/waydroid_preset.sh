#!/bin/env zsh

# waydroid show-full-ui &


while IFS='$\n' read -r line; do
  win_name=$(gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/WindowsExt --method org.gnome.Shell.Extensions.WindowsExt.FocusTitle)
  
  orientation_lock=$(gsettings get org.gnome.settings-daemon.peripherals.touchscreen orientation-lock)
  
  waydroid_name="Waydroid"
  
  # while IFS='$\n' read -r line; do
  current_orientation="$(echo $line | sed -En "s/^.*orientation changed: (.*)/\1/p")"
  previous_orientation=""
  echo $rotation
  
  if [[ "$win_name" == *"$waydroid_name"* ]] && [[ "$orientation_lock" == "false" ]] ; then
    echo "The variable contains the word."
    gnome-randr modify eDP-1 --primary -r normal
    # gsettings set org.gnome.settings-daemon.plugins.orientation active false
    gsettings set org.gnome.settings-daemon.peripherals.touchscreen orientation-lock true
    gnome-extensions enable dash-to-panel@jderose9.github.com
    wmctrl -r :ACTIVE: -b toggle,maximized_vert,maximized_horz

    while [[ "$win_name" == *"$waydroid_name"* ]]; do
      sleep 1
      win_name=$(gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/WindowsExt --method org.gnome.Shell.Extensions.WindowsExt.FocusTitle)
    done

  elif [[ "$win_name" != "$waydroid_name" ]] && [[ "$orientation_lock" == "true" ]] ; then
    echo "The variable does not contain the word."
    # gsettings set org.gnome.settings-daemon.plugins.orientation active true
    gsettings set org.gnome.settings-daemon.peripherals.touchscreen orientation-lock false
    gnome-extensions disable dash-to-panel@jderose9.github.com
    # wmctrl -r :ACTIVE: -b toggle,maximized_vert,maximized_horz

    while [[ "$win_name" != *"$waydroid_name"* ]]; do
      sleep 1
      win_name=$(gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/WindowsExt --method org.gnome.Shell.Extensions.WindowsExt.FocusTitle)
    done
    
  fi
  
  # sleep 1
  #
  #
  #
  #
    current_orientation="$(echo $line | sed -En "s/^.*orientation changed: (.*)/\1/p")"
    previous_orientation=""
    echo $rotation
    if [ "$current_orientation" != "$previous_orientation" ]; then
        echo "Orientation changed from '$previous_orientation' to '$current_orientation'."
        previous_orientation="$current_orientation" # Update the previous orientation
        while ! adb connect 192.168.240.112:5555 ; do sleep 1 ; done
        echo super+1 | dotool

        # --- Commands to run when orientation changes ---
        # You can replace the 'echo' commands below with your actual commands.
        # Examples:
        #   - Run a specific script for portrait mode: if [ "$current_orientation" == "right" ]; then ~/scripts/portrait_setup.sh; fi
        #   - Adjust wallpaper: feh --bg-fill ~/wallpapers/${current_orientation}.jpg
        #   - Send a notification: notify-send "Screen Orientation Changed" "New orientation: ${current_orientation}"

        case "$current_orientation" in
            *"normal"*)
                echo "Screen is now in normal (landscape) orientation."
                # Add your commands for normal orientation here
                # adb shell wm size 1920x1080
                adb shell settings put system user_rotation 0
                ;;
            *"left"*)
                echo "Screen is now rotated left (portrait)."
                # Add your commands for left rotation here
                # adb shell wm size 1080x1920
                adb shell settings put system user_rotation 3
                ;;
            *"right"*)
                echo "Screen is now rotated right (portrait)."
                # Add your commands for right rotation here
                # adb shell wm size 1080x1920
                adb shell settings put system user_rotation 1
                ;;
            *"bottom"*)
                echo "Screen is now inverted (upside-down landscape)."
                # Add your commands for inverted orientation here
                # adb shell wm size 1920x1080
                adb shell settings put system user_rotation 2
                ;;
            *)
                echo "Unknown orientation: $current_orientation"
                ;;
        esac
        # --- End of commands to run ---
    fi
    # [[ !  -z  $rotation  ]] && rotate_ms $rotation
    #
    #
    #
done < <(stdbuf -oL monitor-sensor)
