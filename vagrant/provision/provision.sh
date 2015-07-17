#!/usr/bin/env bash

# Variables
BOX_IP=$1;
VERBOSE=$2;
ANSIBLE_PLAYBOOK=$3

# Check if ansible installed
if ! which ansible > /dev/null; then
	# Ansible does't exist, install it
	echo "Installing ansible";

	# Ansible 1.7.2
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get install -y software-properties-common
	sudo apt-get update
	sudo apt-get install -y ansible

	# Ansible 1.9.2
	#sudo apt-get update -qq
	#sudo apt-get install -y -qq software-properties-common
	#sudo apt-get install -y -qq python-pip python-dev
	#sudo pip -q install ansible
	#mkdir /etc/ansible/
fi

# Ansible provision

sudo cp /vagrant/provision/inventories/dev /etc/ansible/hosts -f
sudo chmod 666 /etc/ansible/hosts
sudo sed -i "s/ip/$BOX_IP/g" /etc/ansible/hosts

echo "Ansible provision start..."

# Run the playbook
if [ "$VERBOSE" = "y" ]; then
	sudo -i ansible-playbook $ANSIBLE_PLAYBOOK --connection=local -v
	#ansible-playbook -i 'localhost,' "${ANSIBLE_PLAYBOOK}" --extra-vars "is_windows=true" --connection=local -v
else
	sudo -i ansible-playbook $ANSIBLE_PLAYBOOK --connection=local
	#ansible-playbook -i 'localhost,' "${ANSIBLE_PLAYBOOK}" --extra-vars "is_windows=true" --connection=local
fi
