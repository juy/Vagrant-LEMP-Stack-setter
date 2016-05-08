# Vagrant LEMP Stack
# A development platform in a box, with everything you would need to develop PHP/Laravel websites.
# See the readme file (README.md) for more information.
# Contribute to this project at : https://github.com/juy/Vagrant-LEMP-Stack-setter


# Check vagrant version
Vagrant.require_version ">= 1.8.0"

# Require
require 'yaml'
require File.expand_path(File.dirname(__FILE__) + '/vagrant/rb/colorizator.rb')
require File.expand_path(File.dirname(__FILE__) + '/vagrant/rb/check_requirements.rb')
require File.expand_path(File.dirname(__FILE__) + '/vagrant/rb/provision_ansible.rb')
require File.expand_path(File.dirname(__FILE__) + '/vagrant/rb/provision_clean.rb')

# Config file path
config_file = "vagrant/config.yml"

# Required plugins
required_plugins = ["vagrant-vbguest", "vagrant-cachier"]

# Check requirements
Check.requirements(config_file, required_plugins)

# Include settings from config file
settings = YAML::load_file(config_file)

# Vagrant configure
Vagrant.configure(2) do |config|

  # Configure the box
  config.vm.box = settings['box']['name']
  config.vm.box_version = settings['box']['version']
  config.vm.box_check_update = false
  config.vm.boot_timeout = 120

  # Set the name of the VM. See: http://stackoverflow.com/a/17864388/100134
  config.vm.define "#{settings['machine_name']}" do |t|
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
  #config.ssh.forward_agent = true

  # Prevent TTY Errors
  #config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  #config.vm.provision "fix-no-tty", type: "shell" do |s|
  #    s.privileged = false
  #    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  #end

  # Private network IP
  config.vm.network :private_network, ip: settings['vm']['ip'], auto_config: false

  # Allow caching to be used
  # http://fgrehm.viewdocs.io/vagrant-cachier/usage
  if settings['use_cachier']
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
          "--memory", settings['vm']['memory'],
          "--cpus", settings['vm']['cpu'],
          "--natdnshostresolver1", "on",
          "--natdnsproxy1", "on",
          "--ioapic", "on",
          "--nestedpaging", "off",
          "--ostype", "Ubuntu_64"
      ]
  end

  # Ansible provisioning
  Provision.ansible(config, settings)

  # Shell provision for box cleaning
  if settings['cleanup']
    Provision.cleanup(config)
  end

end
