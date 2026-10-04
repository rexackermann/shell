#!/bin/bash

# Replace /dev/input/eventX with the actual device path for your tablet mode switch
# DEVICE_PATH="/dev/input/event26"

echo 0 >/tmp/tablet
gnome-extensions enable dash-to-panel@jderose9.github.com && gnome-extensions disable lilypad@shendrew.github.io

# libinput debug-events --device "$DEVICE_PATH" | while read line; do
libinput debug-events | while read -r line; do
  if echo "$line" | grep -q "SWITCH_TOGGLE.*tablet-mode state 1"; then
    echo "Tablet mode detected!"
    # Add your commands to execute in tablet mode here
    echo 1 >/tmp/tablet
    gnome-extensions disable dash-to-panel@jderose9.github.com && gnome-extensions enable lilypad@shendrew.github.io
  elif echo "$line" | grep -q "SWITCH_TOGGLE.*tablet-mode state 0"; then
    echo "Laptop mode detected!"
    # Add your commands to execute in laptop mode here
    echo 0 >/tmp/tablet
    gnome-extensions enable dash-to-panel@jderose9.github.com && gnome-extensions disable lilypad@shendrew.github.io
  fi
done
