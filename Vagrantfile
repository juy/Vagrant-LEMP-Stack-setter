# Vagrant LEMP Stack
# A development platform in a box, with everything you would need to develop PHP/Laravel websites.
# See the readme file (README.md) for more information.
# Contribute to this project at : https://github.com/juy/Vagrant-LEMP-Stack-setter


# Check vagrant version
Vagrant.require_version ">= 1.5.0"

# Require
require 'yaml'
require File.expand_path(File.dirname(__FILE__) + '/vagrant/rb/colorizator.rb')

# Check for config file
$config_file = "vagrant/config.yml"

if File.exists?($config_file)
  $config = YAML::load_file($config_file) # Include config from config file
else
  $text = "\nConfig file is missing: #{$config_file}\n" +
          "Please rename config.example.yml to config.yml in vagrant/ directory"
  abort Colorizator.colorize($text, "light red")
end

# Check required plugins
required_plugins = ["vagrant-vbguest", "vagrant-cachier"]

unless (missing_plugins = required_plugins.select { |p| !Vagrant.has_plugin?(p) }).empty?
  $text = "\nBefore you can 'vagrant up' this box, please install these plugins\n  " +
          missing_plugins.join("\n  ") +
          "\n\nTypically this is done by running\n" +
          "  'vagrant plugin install <plugin>'\nfor each plugin"
  abort Colorizator.colorize($text, "light red")
end

# Vagrant configure
Vagrant.configure(2) do |config|

  # Configure the box
  config.vm.box = $config['box']['name']
  config.vm.box_version = $config['box']['version']
  config.vm.box_check_update = false
  config.vm.boot_timeout = 120

  # Set the name of the VM. See: http://stackoverflow.com/a/17864388/100134
  config.vm.define "#{$config['machine_name']}" do |t|
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
  config.vm.network :private_network, ip: $config['vm']['ip']
  #config.ssh.forward_agent = true

  # Allow caching to be used
  # http://fgrehm.viewdocs.io/vagrant-cachier/usage
  if $config['use_cachier']
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
          "--memory", $config['vm']['memory'],
          "--cpus", $config['vm']['cpu'],
          "--natdnshostresolver1", "on",
          "--natdnsproxy1", "on",
          "--ioapic", "on",
          "--nestedpaging", "off",
          "--ostype", "Ubuntu_64"
      ]
  end

  # Ansible provisioning

  # Set different playbook for development, don't hurt real playbook
  if $config['ansible']['development']
    $playbook = 'playbook-dev'
  else
    $playbook = 'playbook'
  end

  # Provisioning
  if $config['ansible']['provision']
    if Vagrant::Util::Platform.windows?
      config.vm.provision "shell" do |s|
        s.path = "./vagrant/provision/script/ansible_windows.sh"
        s.args = [ "/vagrant/provision/ansible/#{$playbook}.yml", $config['vm']['ip'], ($config['ansible']['verbose']) ? "y" : "n"]
      end
    else
      config.vm.provision :ansible do |ansible|
        ansible.playbook = "vagrant/provision/ansible/#{$playbook}.yml"
        ansible.inventory_path = "vagrant/provision/ansible/inventories/dev"
        ansible.limit = "all"
        ansible.sudo = true
        if $config['ansible']['verbose']
          ansible.verbose = "vv"
        end
      end
    end
  end

  # Shell provision for box cleaning
  if $config['cleanup']
    config.vm.provision "shell", path: "./vagrant/provision/script/vagrant-clean/01-update.sh"
    config.vm.provision "shell", path: "./vagrant/provision/script/vagrant-clean/02-minimize.sh"
    config.vm.provision "shell", path: "./vagrant/provision/script/vagrant-clean/03-cleanup.sh"
    config.vm.provision "shell", path: "./vagrant/provision/script/vagrant-clean/04-whiteout.sh"
  end

end
