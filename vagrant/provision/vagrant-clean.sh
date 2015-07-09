#!/bin/bash

# This script zeroes out any space not needed for packaging a new Ubuntu Vagrant base box.
# Run the following command in a root shell:
# sudo bash /vagrant/provision/vagrant-clean.sh

print_green(){
	echo -e "\e[32m${1}\e[0m"
}


# Update Apt
print_green 'Update Apt'
apt-get update -qq
apt-get upgrade -qq
apt-get dist-upgrade -qq
composer -q self-update
composer -q global update
#npm update -g # no use sudo anymore

# Remove APT cache and files
print_green 'Clean Apt'
apt-get clean -y
apt-get autoclean -y
apt-get autoremove -y
find /var/lib/apt -type f | xargs rm -f

# Remove documentation files
print_green 'Clean docs'
find /var/lib/doc -type f | xargs rm -f

# Remove Linux headers
rm -rf /usr/src/linux-headers*

# Cleanup log and tmp files
print_green 'Cleanup log and tmp files'
rm -rf /tmp/*
rm -f /var/log/wtmp /var/log/btmp
find /var/log -type f | while read f; do echo -ne '' > $f; done;

# Vagrant key
#rm -rf /home/vagrant/.ssh
#mkdir -p /home/vagrant/.ssh
#wget --no-check-certificate https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys
#chmod 0700 /home/vagrant/.ssh
#chmod 0600 /home/vagrant/.ssh/authorized_keys
#chown -R vagrant /home/vagrant/.ssh

# Whiteout root
print_green 'Whiteout root'
count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count
rm /tmp/whitespace

# Whiteout /boot
print_green 'Whiteout /boot'
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count;
rm /boot/whitespace

# Whiteout swap
#print_green 'Whiteout swap'
#swappart=`cat /proc/swaps | tail -n1 | awk -F ' ' '{print $1}'`
#swapoff $swappart
#dd if=/dev/zero of=$swappart
#mkswap -f $swappart
#swapon $swappart

# Zero out disk
print_green 'Zero out disk'
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Remove bash history
print_green 'Cleanup bash history'
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/vagrant/.bash_history
rm -f /home/vagrant/.nano_history
rm -f /home/vagrant/.zhistory
rm -r /home/vagrant/.sudo_as_admin_successful
rm -r /home/vagrant/.redis-commander
history -c

print_green 'Vagrant cleanup complete!'
