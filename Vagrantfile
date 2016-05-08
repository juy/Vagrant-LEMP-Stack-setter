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
require File.expand_path(File.dirname(__FILE__) + '/vagrant/rb/vagrant_config.rb')
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

  # Ansible provisioning
  VagrantConfig.config(config, settings)

  # Ansible provisioning
  Provision.ansible(config, settings)

  # Shell provision for box cleaning
  if settings['cleanup']
    Provision.cleanup(config)
  end

end
