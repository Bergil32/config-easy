#!/bin/bash

# This script will be helpful after reinstalling you operating system
# Tested on Ubuntu 14.04.4 64x

# For testing I used vagrant-box
# https://sourceforge.net/projects/osboxes/files/vms/vbox/Ubuntu/14.04/14.04.4/Ubuntu_14.04.4-64bit.7z/download
ROOT_PASS="osboxes.org"

# Type your own password below which should be correct for you system
#ROOT_PASS=""
# coloured variables
RESET=`tput sgr0`
GREEN=`tput setaf 2`

### Install Shutter http://shutter-project.org/
echo ${GREEN}...................................... Installing Shutter .......................................${RESET}
echo -ne '\n' | add-apt-repository ppa:shutter/ppa
apt-get install shutter -y
echo ${GREEN}.............................................. Done .............................................${RESET}