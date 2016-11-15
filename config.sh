#!/bin/bash

# Set PHP version.
PHP=php7.0

# Entering root user if it wasn't set on script run.
if [ -z "$1" ]; then
    echo "Type the ROOT USER that you have on this PC, followed by [ENTER]:"
    read ROOT_USER
else
    ROOT_USER="$1"
fi

# Entering root password if it wasn't set on script run.
if [ -z "$2" ]; then
    echo "Type the ROOT PASSWORD that you have on this PC, followed by [ENTER]:"
    read ROOT_PASS
else
    ROOT_PASS="$2"
fi

# Adding repositories.
# Skype
add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
# Sublime text 3
echo -ne '\n' | add-apt-repository ppa:webupd8team/sublime-text-3
# Shutter
echo -ne '\n' | add-apt-repository ppa:shutter/ppa

# Update and Upgrade the system.
apt update && apt full-upgrade -y
# Disable guest session.
echo "allow-guest=false" >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
# "vm.swappiness=3" — means that you system will start using swap, when RAM will be full for 97%.
echo "vm.swappiness=3" >> /etc/sysctl.conf

# Install Google Chrome.
apt install libxss1 libappindicator1 libindicator7 -y
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i ./google-chrome*.deb
apt install -f -y
rm -rf google-chrome*.deb

# Install utilities for archive manager with 7z and rar support.
apt install p7zip-full unrar -y

# Install Skype.
# Install dependencies for Skype.
apt install sni-qt:i386 libdbusmenu-qt2:i386 libqt4-dbus:i386 libxss1:i386  -y
apt install libgtk2.0-0:i386 gtk2-engines:i386 libgconf-2-4:i386 -y
# Install Skype.
apt install skype -y
# Install sound plugins for fixing problems with sound for Ubuntu.
apt install libpulse0:i386 -y

# Install SSH Server.
apt install openssh-client openssh-server -y

# Install Git.
apt install git tig -y

# Install curl.
apt install curl -y

# Install PHP extensions.
apt install ${PHP} ${PHP}-cli ${PHP}-curl ${PHP}-intl ${PHP}-json ${PHP}-mbstring ${PHP}-mysql ${PHP}-xml -y

# Install Docker.
echo ${ROOT_PASS} | wget -qO- https://get.docker.com/ | sh
# Add your user to the docker group.
usermod -aG docker $(whoami)
# Install and update python-pip as prerequisite for Docker Compose.
apt install python-pip -y
pip install docker-compose
# Add user to docker group.
usermod -aG docker ${ROOT_USER}
# Add permission for docker.
chmod o+rw /var/run/docker.sock
# Restart Docker.
service docker restart

# Install SublimeText 3.
apt install sublime-text-installer -y

# Install Shutter.
apt install shutter -y

# Running autoremove.
apt autoremove -y

# Rebooting your machine.
reboot
