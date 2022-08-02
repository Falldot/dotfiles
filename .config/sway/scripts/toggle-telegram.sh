#!/bin/sh

# toggle-telegram

telegram=$(swaymsg -t get_tree | jq -r '.nodes[1].nodes[].nodes[] | .. | (.id|tostring) + " " + .name?' | grep -e "[0-9]* ." | grep Telegram)

if [[ -z $telegram ]]
then
    exec telegram-desktop
else
    swaymsg kill telegram-desktop
fi

