# Find the current vagrant directory
#$vagrant_dir = File.expand_path(File.dirname(__FILE__))

# Default config file
#$config_file = $vagrant_dir + "/config.yml"
$config_file = "config.yml"

# Include config from config file
require 'yaml'
$config = YAML::load_file($config_file)

# Vagrant configure
Vagrant.configure(2) do |config|

  # Configure the box
  config.vm.box = "chef/ubuntu-14.10"
  #config.vm.box = "juysoft-ansible"
  #config.vm.box = "vagrant-lemp-stack"
  config.vm.box_check_update = false
  config.vm.boot_timeout = 60
  config.vm.hostname = $config['hostname']

  # SSH settings
  #config.ssh.username = 'vagrant'
  #config.ssh.password = 'vagrant'
  #config.ssh.insert_key = 'true'
  config.ssh.insert_key = false

  # Private network IP
  config.vm.network :private_network, ip: $config['box_ipaddress']

  # Allow caching to be used
  # http://fgrehm.viewdocs.io/vagrant-cachier/usage
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.auto_detect = false
    config.cache.enable :apt
    config.cache.enable :npm
    config.cache.enable :composer
    config.cache.enable :bower
    config.cache.enable :gem
    #config.cache.enable :generic, { "wget" => { cache_dir: "/var/cache/wget" } }
    #config.cache.synced_folder_opts = { type: :nfs }
    #config.cache.synced_folder_opts = { type: :nfs, mount_options: ['rw', 'vers=3', 'tcp', 'nolock'] }
  end

  # Shared folder
  config.vm.synced_folder "./", "/vagrant", type: "nfs"

  # Virtualbox settings
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", $config['box_memory']]
    vb.customize ["modifyvm", :id, "--cpus", $config['box_cpu']]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--nestedpaging", "off"]
    vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
  end

  # Port forwarding
  config.vm.network :forwarded_port, guest: 80, host: 8000, auto_correct: true
  config.vm.network :forwarded_port, guest: 443, host: 44300, auto_correct: true
  config.vm.network :forwarded_port, guest: 3306, host: 33060, auto_correct: true
  config.vm.network :forwarded_port, guest: 5432, host: 54320, auto_correct: true
  config.vm.network :forwarded_port, guest: 6379, host: 63790, auto_correct: true   # Redis
  config.vm.network :forwarded_port, guest: 8501, host: 8501, auto_correct: true    # Beanstalkd console
  config.vm.network :forwarded_port, guest: 8502, host: 8502, auto_correct: true    # Redis commander
  config.vm.network :forwarded_port, guest: 11211, host: 11212, auto_correct: true  # Memcached
  config.vm.network :forwarded_port, guest: 35729, host: 35729, auto_correct: true  # Livereload
  config.vm.network :forwarded_port, guest: 1080, host: 10800, auto_correct: true   # MailCatcher

  # Ansible provisioning
  if $config['ansible_provision'] == true
    if Vagrant::Util::Platform.windows?
      config.vm.provision "shell" do |s|
        s.path = "./provision/provision.sh"
        s.args = [$config['box_ipaddress'], ($config['ansible_verbose'] == true) ? "y" : "n"]
      end
    else
      config.vm.provision :ansible do |ansible|
        ansible.playbook = "provision/playbook.yml"
        ansible.inventory_path = "provision/inventories/dev"
        ansible.limit = "all"
        if $config['ansible_verbose'] == true
          ansible.verbose = "vv"
        end
      end
    end
  end

end
