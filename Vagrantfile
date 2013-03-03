# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'berkshelf/vagrant'

Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.forward_port 3000, 3000

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "rails_env"
    chef.json = {
      ruby: {
        version: '1.9.3-p327'
      },
      postgresql: {
        database: {
          user: 'mgmt',
          password: 'mgmt',
          base_name: 'mgmt'
        },
        password: {
          postgres: 'postgres'
        }
      }
    }
  end

end