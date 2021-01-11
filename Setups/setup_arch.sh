#!/bin/bash

echo "---------------------------"
echo "Welcome to my"
echo "    _    ____   ____ _   _ "
echo "   / \  |  _ \ / ___| | | |"
echo "  / _ \ | |_) | |   | |_| |"
echo " / ___ \|  _ <| |___|  _  |"
echo "/_/   \_\_| \_\\____|_| |_|"
echo "               setup script"
echo "---------------------------"
echo "             made by Defal7"

if [ "$EUID" -ne 0 ]
then
	echo "-------------------------------------"
	echo "Please run this script as Super User."
	echo "-------------------------------------"
	exit
fi


echo "---------------------------"
echo "    Updating the system    "
echo "---------------------------"
pacman -Syu

echo "---------------------------"
echo "    Installing Packages    "
echo "---------------------------"
pacman -S openssh samba base-devel discord flameshot lutris htop screen gimp neofetch keepassxc file-roller grub grub-customizer kdenlive obs-studio flatpak figlet libreoffice peek moc 

echo "----------------------------"
echo " Installing Important Stuff "
echo "----------------------------"
pacman -S atom kate file-roller virt-manager gnome-calculator gnome-disk-utility gnome-multi-writer jre8-openjdk svn bleachbit ffmpeg

echo "VIM"

source vim_plug.sh

echo "youtube-dl"

curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl


#echo "---------------------------"
#echo "    Installing Flatpaks    "
#echo "---------------------------"
#flatpak
#flatpak install unityhub libreoffice

DOAS="Y"
AWN=1
echo "------------------------------------"
echo "   Would you like to install doas?  "
echo "------------------------------------"
read -p "[Y/n]" DOAS

case "$DOAS" in
 [yY] | [yY][eE][sS])
	echo "Doas will be installed in your machine."
	AWN=1	
	;;
 [nN] | [nN][oO])
	echo "Doas will NOT be installed in your machine."
	echo "See ya later!"
	exit
	;;
 *)
	echo "Doas will be installed in your machine."
	AWN=1
	;;
esac
DOASDIR=""

echo "Type the prefered directory for the doas installation"
read -p "" DOASDIR
if [ ! -d "$DOASDIR" ]
then
	echo "Not a Directory, exiting."
fi

echo "The selected directory is: $DOASDIR"
git clone https://github.com/slicer69/doas "$DOASDIR/doas"
cd "$DOASDIR/doas"
make
make install


#yay
mkdir $HOME/Documents
cd $HOME/Documents
cp ../yay $HOME/Documents
makepkg -s
sudo pacman -U yay-10.1.2-1-x86_64.pkg.tar.zst 
yay -Syu

#AUR stuff
yay -S librewolf github-desktop-bin minecraft debtap auto-cpufreq ttf-ms-fonts mint-y-icons

#Debtap
#debtap -u

#auto-cpufreq
#auto-cpufreq --install

# open ssh config
systemctl enable sshd
