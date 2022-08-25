#!/bin/sh

#-----------------------------------------------------

# Video drivers
packages0="mesa vulkan-icd-loader libva-mesa-driver mesa-vdpau"
# Main system packages
packages1="wayland sway swappy swayimg swaync swayidle swaybg swaylock-effects"
packages2="wofi waybar wl-clipboard grim slurp jq foot fish htop polkit mpv nnn"
# Sounds
packages3="pipewire pw-volume"
# Theme and Fonts
packages4="sweet-gtk-theme-dark ttf-fira-code nerd-fonts-fira-code otf-font-awesome"

#-----------------------------------------------------

yay -Syu $packages0 $packages1 $packages2 $packages3 $packages4

#-----------------------------------------------------

# Configs

for file in $(pwd)/.config/*
do
    name="${file##*/}"
    rm -rf $HOME/.config/$name
    ln -s $(pwd)/.config/$name $HOME/.config
done

#-----------------------------------------------------

# Clear

yay -Yc
