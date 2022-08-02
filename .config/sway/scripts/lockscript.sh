#!/bin/sh
swaymsg input "*" xkb_switch_layout 0
swaylock --clock --indicator --screenshots --ring-color c50ed2 --effect-scale 0.4 --effect-vignette 0.2:0.5 --effect-blur 4x2 --datestr "%a %d.%m.%Y" --timestr "%k:%M"