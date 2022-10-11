#!/usr/bin/env bash

# Terminate already running bar instances
pgrep polybar | xargs kill -9

# Wait until the processes have been shut down
while pgrep -u $UID polybar >/dev/null; do sleep 1; done

# Launch bar1 
polybar -c $HOME/.config/i3/polybar/config bar -r &

echo "Bars launched..."
