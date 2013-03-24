# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'berkshelf/vagrant'

Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Network
  config.vm.forward_port 3000, 3000
  config.vm.share_folder("v-root", "/vagrant", ".", :nfs => true)
  config.vm.network :hostonly, "192.168.50.4"

  # Provisioning
  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "rails_env"
    chef.json = {
      ruby: {
        version: '2.0.0-p0'
      },
      postgresql: {
        database: {
          base: 'mgmt'
        },
        password: {
          postgres: 'postgres'
        }
      }
    }
  end

end