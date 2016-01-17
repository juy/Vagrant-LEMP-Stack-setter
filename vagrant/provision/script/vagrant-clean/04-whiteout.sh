#!/bin/bash

print_green(){
    echo -e "\e[32m${1}\e[0m"
}

# Whiteout root
print_green "==> Whiteout root"
count=$(df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}')
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count
rm /tmp/whitespace

# Whiteout boot
print_green "==> Whiteout boot"
count=$(df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}')
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count
rm /boot/whitespace

# Zero out the free space to save space in the final image
# Zero out
print_green "==> Zero out"
#dd if=/dev/zero of=/EMPTY bs=1M
dd if=/dev/zero of=/EMPTY bs=1M | true
rm -f /EMPTY

# Make sure we wait until all the data is written to disk
sync
