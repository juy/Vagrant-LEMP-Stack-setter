# Ansible provisioning
class Provision
    def self.ansible(config, settings)

        # Set different playbook for development, don't hurt real playbook
        if settings['ansible']['development']
          playbook = 'playbook-dev'
        else
          playbook = 'playbook'
        end

        # Provisioning
        if settings['ansible']['provision']
          if Vagrant::Util::Platform.windows?
            config.vm.provision "shell" do |s|
              s.path = "./vagrant/provision/script/ansible_windows.sh"
              s.args = [ "/vagrant/provision/ansible/#{playbook}.yml", settings['vm']['ip'], (settings['ansible']['verbose']) ? "y" : "n"]
            end
          else
            config.vm.provision :ansible do |ansible|
              ansible.playbook = "vagrant/provision/ansible/#{playbook}.yml"
              ansible.inventory_path = "vagrant/provision/ansible/inventories/dev"
              ansible.limit = "all"
              ansible.sudo = true
              if settings['ansible']['verbose']
                ansible.verbose = "vv"
              end
            end
          end
        end

    end
end
