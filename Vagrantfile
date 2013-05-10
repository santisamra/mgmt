# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "mgmt"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.synced_folder ".", "/vagrant", :nfs => true, id: "vagrant-root"
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :private_network, ip: "192.168.50.4"

  config.berkshelf.enabled = true

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