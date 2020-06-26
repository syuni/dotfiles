#!/usr/bin/env bash

DIR=$(dirname $0)

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep .1; done

# Launch Polybar, using default config location ~/.config/polybar/config
for m in $(polybar --list-monitors | cut -d":" -f1); do
  MONITOR=$m polybar desktop &
  MONITOR=$m polybar time &
  MONITOR=$m polybar date &
  MONITOR=$m polybar battery &
  MONITOR=$m PATH=$DIR:$PATH polybar pulse &
done

echo "Polybar launched..."
