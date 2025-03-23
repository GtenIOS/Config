#!/bin/sh

entries="⟳\tReboot\n⏻\tShutdown\n⍇\tLogout"

selected=$(echo -e $entries|wofi --width 250 --height 210 --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

case $selected in
  reboot)
    doas /sbin/reboot;;
  shutdown)
    doas /sbin/poweroff;;
  logout)
    hyprctl dispatch exit;;
esac
