#!/bin/bash

print_green(){
    echo -e "\e[32m${1}\e[0m"
}

# Variables
SSH_USER=${SSH_USERNAME:-vagrant}
#CLEANUP_PAUSE=${CLEANUP_PAUSE:-0}

#print_green "==> Pausing for ${CLEANUP_PAUSE} seconds..."
#sleep ${CLEANUP_PAUSE}

# Make sure udev does not block our network - http://6.ptmc.org/?p=164
#print_green "==> Cleaning up udev rules"
#rm -rf /dev/.udev/
#rm /lib/udev/rules.d/75-persistent-net-generator.rules

print_green "==> Cleaning up leftover dhcp leases"
if [ -d "/var/lib/dhcp" ]; then
    rm /var/lib/dhcp/*
fi

# Add delay to prevent "vagrant reload" from failing
#echo "pre-up sleep 2" >> /etc/network/interfaces

print_green "==> Cleaning up tmp"
#rm -rf /tmp/*
find . -name ".*" -exec rm -rf {};

print_green "==> Cleanup apt cache"
apt-get -y autoremove --purge
apt-get -y clean
apt-get -y autoclean
print_green "==> Removing APT files"
find /var/lib/apt -type f | xargs rm -f

#print_green "==> Installed packages"
#dpkg --get-selections | grep -v deinstall

print_green "==> Remove Bash history"
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/${SSH_USER}/.bash_history
rm -f /home/${SSH_USER}/.nano_history
rm -f /home/${SSH_USER}/.zhistory
rm -r /home/${SSH_USER}/.sudo_as_admin_successful
rm -r /home/${SSH_USER}/.redis-commander

print_green "==> Clean up log files"
find /var/log -type f | while read f; do echo -ne '' > $f; done;

print_green "==> Clearing last login information"
>/var/log/lastlog
>/var/log/wtmp
>/var/log/btmp

print_green "==> Disk usage after cleanup"
df -h
