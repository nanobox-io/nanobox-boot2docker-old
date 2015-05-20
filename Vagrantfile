# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$script = <<SCRIPT
# fetch boot2docker starting point
docker pull boot2docker/boot2docker
# create new docker image to output custom iso
docker build -t pagoda-b2d /vagrant/pagoda-b2d
# run custom docker image and capture output to iso
docker run --rm pagoda-b2d > /vagrant/pagoda-b2d.iso
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.box     = "glinton/boot2docker"
  config.vm.box_url = "https://bitbucket.org/beuford/boot2docker-nanobox/downloads/pb-b2d_virtualbox.box"

  config.vm.synced_folder ".", "/vagrant", readonly: false

  # Create custom iso
  config.vm.provision "shell", inline: $script

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "1500"]
  end

end
