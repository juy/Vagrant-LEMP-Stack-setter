#!/usr/bin/env bash

# Variables
ANSIBLE_PLAYBOOK=$1
BOX_IP=$2;
VERBOSE=$3;

# Make sure Ansible playbook exists
if [ ! -f "$ANSIBLE_PLAYBOOK" ]; then
    echo "Cannot find Ansible playbook."
    exit 1
fi

# Check if ansible installed
if ! which ansible > /dev/null; then
    # Ansible does't exist, install it
    echo "Installing ansible";

    # Install ansible - On test ansible version is 1.9.4
    sudo apt-get update -qq
    sudo apt-get install -y -qq software-properties-common
    sudo apt-add-repository -y ppa:ansible/ansible
    sudo apt-get update -qq
    sudo apt-get install -y -qq ansible
    sudo apt-get install -y -qq sshpass
fi

# Ansible provision

# Setup hosts file; only need to show correct ip address on provisioning.
sudo cp /vagrant/provision/ansible/inventories/dev /etc/ansible/hosts -f
sudo chmod 666 /etc/ansible/hosts
sudo sed -i "s/ip/$BOX_IP/g" /etc/ansible/hosts

echo "Ansible provision start..."

# Run the playbook
if [ "$VERBOSE" = "y" ]; then
    sudo -i ansible-playbook $ANSIBLE_PLAYBOOK --connection=local -v
else
    sudo -i ansible-playbook $ANSIBLE_PLAYBOOK --connection=local
fi
