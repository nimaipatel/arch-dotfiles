#!/bin/bash
while true; do
  stat=""
  stat+="     "
  stat+="(._.)  "
  stat+="$(date '+%A %d %B, %Y %I:%M%p ')  "
  stat+="BAT $(cat /sys/class/power_supply/BAT1/capacity)% "
  bat_stat=$(cat /sys/class/power_supply/BAT1/status)
  if [ "$bat_stat" = "Charging" ]; then
    stat+="$bat_stat  "
  fi
  vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
  if [[ "$vol" =~ [MUTED] ]]; then
    stat+="muted  "
  fi
  stat+="     "
  xsetroot -name "$stat"
  sleep 1
done
