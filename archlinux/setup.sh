PARTITION_EFI=/dev/sda1
PARTITION_BOOT=/dev/sda2
PARTITION_ENCRYPTED=/dev/sda3
SWAP_SIZE=12G
USER_NAME=alex
ETHERNET_INTERFACE=ens3

mkfs.vfat -F 32 ${PARTITION_EFI}
mkfs.ext4 ${PARTITION_BOOT}
cryptsetup -h sha512 -s 512 --use-random -y -v luksFormat ${PARTITION_ENCRYPTED}
cryptsetup luksOpen ${PARTITION_ENCRYPTED} secret
pvcreate /dev/mapper/secret
vgcreate arch /dev/mapper/secret
lvcreate -L +${SWAP_SIZE} arch -n swap
lvcreate -l +100%FREE arch -n root
mkswap /dev/mapper/arch-swap
mkfs.ext4 /dev/mapper/arch-root
swapon /dev/mapper/arch-swap
mount /dev/mapper/arch-root /mnt
mkdir /mnt/boot
mount ${PARTITION_BOOT} /mnt/boot
mkdir /mnt/boot/efi
mount ${PARTITION_EFI} /mnt/boot/efi
pacstrap /mnt base base-devel grub efibootmgr dialog wpa_supplicant linux linux-headers linux-firmware vim dhcpcd iwd lvm2 man-pages
genfstab -U /mnt >> /mnt/etc/fstab

curl -o /mnt/root_setup.sh -sSL https://raw.githubusercontent.com/alexhokl/installation/master/archlinux/root_setup.sh
chmod +x /mnt/root_setup.sh

arch-chroot /mnt passwd
arch-chroot /mnt useradd -m -G wheel -s /bin/bash $USER_NAME
arch-chroot /mnt passwd $USER_NAME

arch-chroot /mnt ./root_setup.sh

arch-chroot /mnt sed -i -e 's/GRUB_CMDLINE_LINUX=\"\"/GRUB_CMDLINE_LINUX=\"cryptdevice=\/dev\/sda3:secret resume=\/dev\/mapper\/arch-swap\"/g' /etc/default/grub
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

arch-chroot /mnt systemctl enable dhcpcd@$ETHERNET_INTERFACE

USER_SETUP_SCRIPT_FILE=/home/$USER_NAME/setup.sh
arch-chroot /mnt curl -o $USER_SETUP_SCRIPT_FILE -sSL https://raw.githubusercontent.com/alexhokl/installation/master/archlinux/user_setup.sh
arch-chroot /mnt chmod +x $USER_SETUP_SCRIPT_FILE
arch-chroot /mnt chown $USER_NAME:$USER_NAME $USER_SETUP_SCRIPT_FILE

umount -R /mnt
swapoff -a
reboot
