# Интернет

Автоматическое подключение к сети, если проводной интернет
```sh
dhcpcd
```

Разблокировать утилиту wifi адаптер
```sh
rfkill unblock wifi
```

Вывод списка доступных беспроводных интерфейсов
```sh
ip a
```

Включаем наш wifi адаптер
```
ip link set ${имя_беспроводного_интерфейса} up
```

```sh
iwctl
station ${имя_беспроводного_интерфейса} connect ${имя_сети}
```

```
ping google.com
```

# Разметка диска

Смотрим имя дисков
```sh
fdisk -l
```

Создаем таблицу разделов gpt
```sh
fdisk ${диск}
g
d # для удаления разделов
w
```

Разметка диска:
```sh
cfdisk ${диск}
```
* 31MB - BIOS boot
* 300MB - EFI System / boot_раздел
* other - Linux filesystem / root_раздел

Форматируем efi раздел в fat
```sh
mkfs.vfat ${boot_раздел}
```

Форматируем корневой раздел в btrfs
```sh
mkfs.btrfs ${root_раздел}
# В случаи ошибки
mkfs.btrfs -f ${root_раздел}
```

Монтируем разделы
```sh
mount ${root_раздел} /mnt

mkdir /mnt/boot
mkdir /mnt/boot/EFI # если EFI

mount ${boot_раздел} /mnt/boot
mount ${boot_раздел} /mnt/boot/EFI # если EFI
```

# Установка системы
```sh
pacstrap -i /mnt base base-devel linux-zen linux-zen-headers linux-firmware btrfs-progs intel-ucode iucode-tool nano
```

Файл конфигурации файловых систем
```sh
genfstab -U /mnt >> /mnt/etc/fstab
# проверяем
cat /mnt/etc/fstab
```

Входим в систему
```sh
arch-chroot /mnt
```

Установка региона
```
ln -sf /usr/share/zoneinfo/Asia/Sakhalin /etc/localtime
hwclock --systohc
```

Устанавливаем языки
```
nano /etc/locale.gen
```
* en_US.UTF-8 UTF-8
* ru_RU.UTF-8 UTF-8
```sh
locale-gen
nano /etc/locale.conf # >>> LANG=ru_RU.UTF-8
nano /etc/vconsole.conf
# KEYMAP=ru
# FONT=cyr-sun16
```

Установливаем имя компьютера
```sh
nano /etc/hostname # >>> ARCH
```

Установливаем хосты
```sh
nano /etc/hosts
# 127.0.0.1 localhost
# ::1       localhost
# 127.0.0.1 ARCH.localdomain  ARCH
```

Создаем образ ядра для ОЗУ
```sh
mkinitcpio -P
```

Установка пароля root
```
passwd
```

Загрузчик
```sh
pacman -S grub efibootmgr dhcpcd dhclient networkmanager

grub-install ${диск}
# если ошибка
grub-install ${диск} --boot-directory=/boot/EFI

grub-mkconfig -o /boot/grub/grub.cfg
```

```
exit
umount -R /mnt
reboot
```

# Настройка системы

```sh
nano /etc/sudoers
# %wheel ALL=(ALL) ALL
```

```sh
useradd -m -G wheel -s /bin/bash ${name} # only smallcase
passwd ${name}
exit
```

```sh
sudo su
systemctl enable NetworkManager
reboot
```

wifi
```sh
nmcli d wifi connect ${имя_сети} password ${password}
ping google.com
```

pacman
```sh
sudo nano /etc/pacman.conf
# ParallelDownloads = threads + 1
#
# multitub
# include ...

sudo nano /etc/pacman.d/mirrorlist
# Server = https://mirror.yandex.ru/archlinux/$repo/os/$arch
```

# SSD

```sh
sudo systemctl enable fstrim.timer
```

# YAY

pacman -Syu git

sudo mkdir -rf $HOME/aur.archlinux.org
cd $HOME/aur.archlinux.org && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si 
yay -Y --gendb