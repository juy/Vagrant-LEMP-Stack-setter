class Check
    def self.requirements(config_file, required_plugins)

        # Check for config file
        unless File.exists?(config_file)
          text = "\nConfig file is missing: #{config_file}\n" +
                  "Please rename config.example.yml to config.yml in vagrant/ directory"
          abort Colorizator.colorize(text, "light red")
        end

        # Check required plugins
        unless (missing_plugins = required_plugins.select { |p| !Vagrant.has_plugin?(p) }).empty?
          text = "\nBefore you can 'vagrant up' this box, please install these plugins\n  " +
                  missing_plugins.join("\n  ") +
                  "\n\nTypically this is done by running\n" +
                  "  'vagrant plugin install <plugin>'\nfor each plugin"
          abort Colorizator.colorize(text, "light red")
        end

    end
end
