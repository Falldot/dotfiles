#!/bin/sh

AUR=aur.archlinux.org

pacman -Syu

echo '[MY_SCRIPT] Установка alacritty fish wofi htop'
sudo pacman -S alacritty fish wofi htop

sudo mkdir -rf $HOME/$AUR
sudo mkdir $HOME/screenshots

echo '[MY_SCRIPT] Установка yay'
sudo pacman -S git
cd $HOME/$AUR && git clone https://$AUR/yay.git && cd yay && makepkg -si 
yay -Y --gendb

echo '[MY_SCRIPT] Sway'
yay -S wayland polkit sway swaybg-git swaylock-git swayimg-git swaylock-effects-git swayidle-git waybar-git wlay-git wl-clipboard-git otf-font-awesome swaync-git grim-git slurp-git swappy-git jq-git

echo '[MY_SCRIPT] Установка Fira Code шрифт'
yay -S ttf-fira-code nerd-fonts-fira-code

echo '[MY_SCRIPT] Pipeware'
yay -S pipewire pipewire-alsa pipewire-pulse pipewire-jack pw-volume

echo '[MY_SCRIPT] Sway'
rm -rf $HOME/.config/sway
ln -s $(pwd)/.config/sway $HOME/.config

echo '[MY_SCRIPT] Waybar'
rm -rf $HOME/.config/waybar
ln -s $(pwd)/.config/waybar $HOME/.config

echo '[MY_SCRIPT] Alacritty'
rm -rf $HOME/.config/alacritty
ln -s $(pwd)/.config/alacritty $HOME/.config

echo '[MY_SCRIPT] Fish'
chsh -s /usr/bin/fish
rm -rf $HOME/.config/fish
ln -s $(pwd)/.config/fish $HOME/.config

echo '[MY_SCRIPT] Swaync'
rm -rf $HOME/.config/swaync
ln -s $(pwd)/.config/swaync $HOME/.config

sudo pacman -Sc
