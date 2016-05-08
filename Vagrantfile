# Vagrant LEMP Stack
# A development platform in a box, with everything you would need to develop PHP/Laravel websites.
# See the readme file (README.md) for more information.
# Contribute to this project at : https://github.com/juy/Vagrant-LEMP-Stack-setter


# Check vagrant version
Vagrant.require_version ">= 1.5.1"

# Require
require 'yaml'
require File.expand_path(File.dirname(__FILE__) + '/vagrant/rb/colorizator.rb')
require File.expand_path(File.dirname(__FILE__) + '/vagrant/rb/check_requirements.rb')

# Config file path
config_file = "vagrant/config.yml"

# Required plugins
required_plugins = ["vagrant-vbguest", "vagrant-cachier"]

# Check requirements
Check.requirements(config_file, required_plugins)

# Include settings from config file
$settings = YAML::load_file(config_file)

# Vagrant configure
Vagrant.configure(2) do |config|

  # Configure the box
  config.vm.box = $settings['box']['name']
  config.vm.box_version = $settings['box']['version']
  config.vm.box_check_update = false
  config.vm.boot_timeout = 120

  # Set the name of the VM. See: http://stackoverflow.com/a/17864388/100134
  config.vm.define "#{$settings['machine_name']}" do |t|
  end

  # https://github.com/dotless-de/vagrant-vbguest
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end

  # SSH settings
  #config.ssh.username = "vagrant"
  #config.ssh.password = "vagrant"
  #config.ssh.insert_key = true
  config.ssh.insert_key = false

  # Private network IP
  config.vm.network :private_network, ip: $settings['vm']['ip']
  #config.ssh.forward_agent = true

  # Allow caching to be used
  # http://fgrehm.viewdocs.io/vagrant-cachier/usage
  if $settings['use_cachier']
    if Vagrant.has_plugin?("vagrant-cachier")
      config.cache.scope = :box
      config.cache.auto_detect = false
      config.cache.enable :apt
      #config.cache.enable :npm  # Make problems
      config.cache.enable :composer
      config.cache.enable :bower
      config.cache.enable :gem
      #config.cache.enable :generic, { "wget" => { cache_dir: "/var/cache/wget" } }
    end
  end

  # Shared folder
  config.vm.synced_folder "./vagrant", "/vagrant", type: "nfs"

  # Virtualbox settings
  config.vm.provider :virtualbox do |v|
      v.customize [
          "modifyvm", :id,
          "--memory", $settings['vm']['memory'],
          "--cpus", $settings['vm']['cpu'],
          "--natdnshostresolver1", "on",
          "--natdnsproxy1", "on",
          "--ioapic", "on",
          "--nestedpaging", "off",
          "--ostype", "Ubuntu_64"
      ]
  end

  # Ansible provisioning

  # Set different playbook for development, don't hurt real playbook
  if $settings['ansible']['development']
    $playbook = 'playbook-dev'
  else
    $playbook = 'playbook'
  end

  # Provisioning
  if $settings['ansible']['provision']
    if Vagrant::Util::Platform.windows?
      config.vm.provision "shell" do |s|
        s.path = "./vagrant/provision/script/ansible_windows.sh"
        s.args = [ "/vagrant/provision/ansible/#{$playbook}.yml", $settings['vm']['ip'], ($settings['ansible']['verbose']) ? "y" : "n"]
      end
    else
      config.vm.provision :ansible do |ansible|
        ansible.playbook = "vagrant/provision/ansible/#{$playbook}.yml"
        ansible.inventory_path = "vagrant/provision/ansible/inventories/dev"
        ansible.limit = "all"
        ansible.sudo = true
        if $settings['ansible']['verbose']
          ansible.verbose = "vv"
        end
      end
    end
  end

  # Shell provision for box cleaning
  if $settings['cleanup']
    config.vm.provision "shell", path: "./vagrant/provision/script/vagrant-clean/01-update.sh"
    config.vm.provision "shell", path: "./vagrant/provision/script/vagrant-clean/02-minimize.sh"
    config.vm.provision "shell", path: "./vagrant/provision/script/vagrant-clean/03-cleanup.sh"
    config.vm.provision "shell", path: "./vagrant/provision/script/vagrant-clean/04-whiteout.sh"
  end

end
