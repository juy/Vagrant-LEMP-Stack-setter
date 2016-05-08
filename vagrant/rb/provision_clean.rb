# Shell provision for box cleaning
class Provision
    def self.clean(config, settings)
        config.vm.provision "shell", path: "./vagrant/provision/script/vagrant-clean/01-update.sh"
        config.vm.provision "shell", path: "./vagrant/provision/script/vagrant-clean/02-minimize.sh"
        config.vm.provision "shell", path: "./vagrant/provision/script/vagrant-clean/03-cleanup.sh"
        config.vm.provision "shell", path: "./vagrant/provision/script/vagrant-clean/04-whiteout.sh"
    end
end
