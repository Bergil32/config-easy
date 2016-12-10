#!/bin/bash

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
