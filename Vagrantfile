# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "private_network", ip: "192.168.33.77"
  config.vm.provision "shell", path: "bootstrap.sh"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096
    vb.cpus = 1
  end
end
