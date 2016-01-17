#!/bin/bash

print_green(){
    echo -e "\e[32m${1}\e[0m"
}

print_green "==> Disk usage before cleanup"
df -h

#echo "==> Installed packages before cleanup"
#dpkg --get-selections | grep -v deinstall

# Remove some packages to get a minimal install
print_green "==> Removing all linux kernels except the currrent one"
dpkg --list | awk '{ print $2 }' | grep 'linux-image-3.*-generic' | grep -v $(uname -r) | xargs apt-get -y purge
print_green "==> Removing linux source"
dpkg --list | awk '{ print $2 }' | grep linux-source | xargs apt-get -y purge
print_green "==> Removing development packages"
dpkg --list | awk '{ print $2 }' | grep -- '-dev$' | xargs apt-get -y purge
print_green "==> Removing documentation"
dpkg --list | awk '{ print $2 }' | grep -- '-doc$' | xargs apt-get -y purge
#print_green "==> Removing development tools"
#dpkg --list | grep -i compiler | awk '{ print $2 }' | xargs apt-get -y purge
#apt-get -y purge cpp gcc g++
#apt-get -y purge build-essential git
#print_green "==> Removing default system Ruby"
#apt-get -y purge ruby ri doc
#print_green "==> Removing default system Python"
#apt-get -y purge python-dbus libnl1 python-smartpm python-twisted-core libiw30 python-twisted-bin libdbus-glib-1-2 python-pexpect python-pycurl python-serial python-gobject python-pam python-openssl libffi5
#print_green "==> Removing X11 libraries"
#apt-get -y purge libx11-data xauth libxmuu1 libxcb1 libx11-6 libxext6
#print_green "==> Removing obsolete networking components"
#apt-get -y purge ppp pppconfig pppoeconf
#print_green "==> Removing other oddities"
#apt-get -y purge popularity-contest installation-report landscape-common wireless-tools wpasupplicant ubuntu-serverguide

# Clean up orphaned packages with deborphan
apt-get -qq install deborphan
while [ -n "$(deborphan --guess-all --libdevel)" ]; do
    deborphan --guess-all --libdevel | xargs apt-get -qq purge
done
apt-get -qq purge deborphan dialog

print_green "==> Removing man pages"
rm -rf /usr/share/man/*
print_green "==> Removing any docs"
rm -rf /usr/share/doc/*
print_green "==> Removing caches"
find /var/cache -type f -exec rm -rf {} \;
