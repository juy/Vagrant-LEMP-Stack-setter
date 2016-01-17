#!/bin/bash

print_green(){
    echo -e "\e[32m${1}\e[0m"
}
#print_green 'Test'

# Disable the release upgrader
#print_green '==> Disabling the release upgrader'
#sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades

print_green "==> Updating list of repositories"
# apt-get update does not actually perform updates, it just downloads and indexes the list of packages
apt-get -qq update

# Check if composer installed
if which composer > /dev/null; then
    # Update composer self and global packages
    composer -q self-update
    composer -q global update
fi

# Check if npm installed
#if which npm > /dev/null; then
    # Update npm global packages
    #npm update -g # no use sudo anymore # need manuel update for this
    #su vagrant -c npm update -g # Need test
#fi


#if [[ $UPDATE  =~ true || $UPDATE =~ 1 || $UPDATE =~ yes ]]; then
#    print_green "==> Performing dist-upgrade (all packages and kernel)"
#    apt-get -y dist-upgrade --force-yes
#    reboot
#    sleep 60
#fi
