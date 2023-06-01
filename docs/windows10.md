# Windows 10

## Setup

* Install scoop
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
```
* Install main apps and configs
```sh
./setup.ps1
```

## C++
* [XMake](https://github.com/xmake-io/xmake/) - A cross-platform build utility
* [Visual Studio](https://visualstudio.microsoft.com/ru/)
```sh
scoop install main/xmake
```

---

## WSL
* [ArchWSL](https://github.com/yuk7/ArchWSL) - ArchLinux based WSL Distribution.
```sh
wls --install

scoop install extras/archwsl
```

```sh
nano /etc/sudoers
# %wheel ALL=(ALL) ALL
```

```sh
useradd -m -G wheel -s /bin/bash ${username} # only smallcase
passwd ${username}
exit
```
```sh
Arch.exe config --default-user ${username}
```
```sh
sudo chown -R falldot /home/${username}
```

* Pacman
```sh
sudo nano /etc/pacman.conf
# ParallelDownloads = threads + 1
#
# multitub
# include ...

sudo nano /etc/pacman.d/mirrorlist
# Server = https://mirror.yandex.ru/archlinux/$repo/os/$arch
```

* Initialize keyring
```sh
sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Sy archlinux-keyring
sudo pacman -Su
```

* [Yay](https://github.com/Jguer/yay) - AUR Helper
```sh
pacman -Syu base-devel htop git

sudo mkdir -rf $HOME/aur.archlinux.org
cd $HOME/aur.archlinux.org 
git clone https://aur.archlinux.org/yay.git 
cd yay && makepkg -si 
yay -Y --gendb
```

* [Fish](https://github.com/fish-shell/fish-shell) - Command line shell
```sh
yay -S fish

chsh -s /usr/bin/fish
```

* [FiraCode](https://github.com/tonsky/FiraCode) - Monospaced font with programming ligatures
* [FiraCodeNerd](https://github.com/ryanoasis/nerd-fonts) - Icon patcher for Fira Code
* [FontAwesome](https://github.com/FortAwesome/Font-Awesome) - The iconic font
```sh
yay -S ttf-fira-code nerd-fonts-fira-code otf-font-awesome
```

* [Starship](https://github.com/starship/starship) -  Customizable prompt for shell
```sh
yay -S starship
```
Add the following to the end of ~/.config/fish/config.fish
```
starship init fish | source
```

* [Docker](https://www.docker.com/)
```sh
yay -S docker

sudo groupadd docker
sudo usermod -aG docker $USER
```

* [wsl2-docker-start](https://github.com/imjonos/wsl2-docker-start)
```sh
git clone https://github.com/imjonos/wsl2-docker-start.git
cd wsl2-docker-start
chmod +x docker-start prepare-hosts
sudo cp docker-start prepare-hosts /usr/local/bin
```

* ArchLinux as default WSL
```sh
wsl --set-default Arch
```

* Remove Ubuntu
```sh
wsl --unregister Ubuntu
```