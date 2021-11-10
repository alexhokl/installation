sed -i -e 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers
sed -i -e 's/#\en_GB\.UTF\-8/en_GB\.UTF\-8/g' /etc/locale.gen
ln -sf /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime
locale-gen
echo LANG=en_GB.UTF-8 > /etc/locale.conf
echo alex-arch > /etc/hostname

sed -i -e 's/block filesystems/block keymap encrypt lvm2 resume filesystems/g' /etc/mkinitcpio.conf
mkinitcpio -p linux
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ArchLinux

