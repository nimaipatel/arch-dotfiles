#!/usr/bin/env bash

# Terminate already running bar instances
killall polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

source ~/.config/polybar/polybar-base16.sh

# Launch polybar
polybar top -c $(dirname $0)/config.ini &
polybar bottom -c $(dirname $0)/config.ini &
