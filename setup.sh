#!/bin/sh

AUR=aur.archlinux.org

#-----------------------------------------------------

# Video drivers
packages0="mesa vulkan-icd-loader libva-mesa-driver mesa-vdpau"
# Main system packages 
packages1="wayland sway swaybg swappy swayimg swaync swayidle swaylock-effects"
packages2="wofi waybar wl-clipboard grim slurp jq foot fish htop polkit mpv"
# Sounds
packages3="pipewire pw-volume"
# Fonts
packages4="ttf-fira-code nerd-fonts-fira-code otf-font-awesome"

#-----------------------------------------------------

# YAY

pacman -Syu git

sudo mkdir -rf $HOME/$AUR
cd $HOME/$AUR && git clone https://$AUR/yay.git && cd yay && makepkg -si 
yay -Y --gendb

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
