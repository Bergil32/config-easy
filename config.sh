#!/bin/bash

# Coloured variables for script
RESET=`tput sgr0`
GREEN=`tput setaf 2`

# Set PHP version.
PHP=php7.0

# Entering root user if it wasn't set on script run
if [ -z "$1" ]; then
    echo "Type the ROOT USER that you have on this PC, followed by [ENTER]:"
    read ROOT_USER
else
    ROOT_USER="$1"
fi

# Entering root password if it wasn't set on script run
if [ -z "$2" ]; then
    echo "Type the ROOT PASSWORD that you have on this PC, followed by [ENTER]:"
    read ROOT_PASS
else
    ROOT_PASS="$2"
fi

### Adding repositories.
echo ${GREEN}... Adding repositories ...${RESET}
# Skype
add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
# Sublime text 3
echo -ne '\n' | add-apt-repository ppa:webupd8team/sublime-text-3
# Shutter
echo -ne '\n' | add-apt-repository ppa:shutter/ppa

### Update and Upgrade the system
echo ${GREEN}... Update and Upgrade the system ...${RESET}
apt update && apt full-upgrade -y
# Disable guest session
echo "allow-guest=false" >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
# Configuring system to allow more performance
# "vm.swappiness=3" — means that you system will start using swap, when RAM will be full for 97%
echo "vm.swappiness=3" >> /etc/sysctl.conf

### Install Google Chrome https://www.google.com/chrome/
echo ${GREEN}... Installing Google Chrome ...${RESET}
apt install libxss1 libappindicator1 libindicator7 -y
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i ./google-chrome*.deb
apt install -f -y
rm -rf google-chrome*.deb

### Install utilities for archive manager with 7z and rar support
echo ${GREEN}... Installing 7z and Unrar ...${RESET}
apt install p7zip-full unrar -y

### Install Skype http://www.skype.com/
# Install dependencies for Skype
apt install sni-qt:i386 libdbusmenu-qt2:i386 libqt4-dbus:i386 libxss1:i386  -y
apt install libgtk2.0-0:i386 gtk2-engines:i386 libgconf-2-4:i386 -y
# Install Skype
apt install skype -y
# Install sound plugins for fixing problems with sound for Ubuntu
apt install libpulse0:i386 -y

### Install SSH Server http://www.openssh.com/
echo ${GREEN}... Installing SSH Server ...${RESET}
apt install openssh-client openssh-server -y

### Install Git https://git-scm.com/
echo ${GREEN}... Installing Git ...${RESET}
apt install git tig -y

### Install curl
echo ${GREEN}... Installing curl...${RESET}
apt install curl -y

### Install PHP extensions.
echo ${GREEN}... Installing PHP exstensions ...${RESET}
apt install ${PHP} ${PHP}-cli ${PHP}-curl ${PHP}-intl ${PHP}-json ${PHP}-mbstring ${PHP}-mysql ${PHP}-xml -y

### Install Docker https://www.docker.com/
echo ${GREEN}... Installing and Configuring Docker ...${RESET}
# Install Docker
echo ${ROOT_PASS} | wget -qO- https://get.docker.com/ | sh
# Add your user to the docker group
usermod -aG docker $(whoami)
# Install and update python-pip as prerequisite for Docker Compose
apt install python-pip -y
pip install docker-compose
# Add user to docker group
usermod -aG docker ${ROOT_USER}
# Add permission for docker
chmod o+rw /var/run/docker.sock
# Restart Docker
service docker restart

### Install SublimeText 3 https://www.sublimetext.com/3
echo ${GREEN}... Installing SublimeText3 ...${RESET}
apt install sublime-text-installer -y

### Install Shutter
echo ${GREEN}... Installing Shutter...${RESET}
apt install shutter -y

### Running autoremove
echo ${GREEN}... Running autoremove ...${RESET}
apt autoremove -y

### Rebooting your machine
echo ${GREEN}... Rebooting ...${RESET}
sleep 3
reboot
