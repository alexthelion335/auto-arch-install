#!/bin/bash
drive=/dev/sda
hostname=new-arch-box
user=alex
passwd=password
echo "--------------------------"
echo "-  Welcome to            -"
echo "-  Alex Kinch's          -"
echo "-  Arch Install          -"
echo "-  script!               -"
echo "--------------------------"
sleep 1
echo -e "\nYou will need to know what drive to install Arch Linux on."
echo "If it is not /dev/sda, you will need to change the script."
sleep 1
fdisk ${drive} << EOF
  o
  n
  p
  1
    
  -2G
  n
  p
  2
   
   
  a
  1
  t
  2
  82
  p
  w
  q
EOF
echo -e "\nDrive $drive was formatted!"
mkfs.ext4 ${drive}1
mkswap ${drive}2
swapon ${drive}2
mount ${drive}1 /mnt
echo -e "\nSwap activated and drive mounted!"
timedatectl set-ntp true
timedatectl status
echo -e "\nTime and date set!"
echo -e "\nInstalling base system..."
sleep 1
pacstrap /mnt base linux linux-firmware nano vim sudo base-devel git wget networkmanager dhcpcd grub xorg-server xf86-video-vesa xorg-xinit neofetch openbox tint2 nitrogen gdm firefox konsole xterm mpv thunar dolphin picom inkscape gimp cmatrix lynx lolcat cowsay
echo -e "\nBase system installed!"
genfstab -U /mnt >> /mnt/etc/fstab
echo -e "\nFstab configured!"
cp install-arch2.sh /mnt/
echo -e "\nYou will have to type ./install-arch2.sh to continue."
arch-chroot /mnt

