#!/bin/sh

# Время выключения экрана и перевод его в фоновый режим
swayidle \
    timeout 10 'swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' &
# Блокируем экран
exec bash ~/.config/sway/scripts/lockscript.sh
# Убивает последнюю фоновую задачу, поэтому таймер простоя не продолжает работать
kill %%
