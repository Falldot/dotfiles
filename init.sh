#!/bin/sh

AUR=aur.archlinux.org

pacman -Syu

sudo mkdir -rf $HOME/$AUR
sudo mkdir $HOME/screenshots

echo '[MY_SCRIPT] Установка yay'
sudo pacman -S git
cd $HOME/$AUR && git clone https://$AUR/yay.git && cd yay && makepkg -si 
yay -Y --gendb

yay -Syu

echo '[MY_SCRIPT] Sway'
yay -S wayland sway swaybg swappy swayimg swaync swayidle swaylock-effects wofi waybar wlay wl-clipboard grim slurp jq alacritty fish htop polkit

echo '[MY_SCRIPT] Установка шрифтов'
yay -S ttf-fira-code nerd-fonts-fira-code otf-font-awesome

echo '[MY_SCRIPT] Pipeware'
yay -S pipewire pw-volume

echo '[MY_SCRIPT] Sway'
rm -rf $HOME/.config/sway
ln -s $(pwd)/.config/sway $HOME/.config

echo '[MY_SCRIPT] Waybar'
rm -rf $HOME/.config/waybar
ln -s $(pwd)/.config/waybar $HOME/.config

echo '[MY_SCRIPT] Swaync'
rm -rf $HOME/.config/swaync
ln -s $(pwd)/.config/swaync $HOME/.config

echo '[MY_SCRIPT] Foot'
rm -rf $HOME/.config/foot
ln -s $(pwd)/.config/foot $HOME/.config

echo '[MY_SCRIPT] Fish'
chsh -s /usr/bin/fish
rm -rf $HOME/.config/fish
ln -s $(pwd)/.config/fish $HOME/.config

echo '[MY_SCRIPT] Wofi'
rm -rf $HOME/.config/wofi
ln -s $(pwd)/.config/wofi $HOME/.config
