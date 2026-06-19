#!/usr/bin/env bash

# wait for xdg-desktop-portal-hyprland to start
until pgrep -f 'xdg-desktop-portal-hyprland'; do sleep 2; done

kill $(pidof waybar)
while pgrep -u $UID -x waybar >/dev/null; do sleep 1; done
waybar &

nm-applet --indicator &
blueman-applet &
