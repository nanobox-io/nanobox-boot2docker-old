# -*- mode: ruby -*-
# vi: set ft=ruby :

version = File.read("version")

$wait = <<SCRIPT
echo "Waiting for docker sock file"
while [ ! -S /var/run/docker.sock ]; do
  sleep 1
done
SCRIPT

$script = <<SCRIPT
# fetch boot2docker starting point
docker pull boot2docker/boot2docker
# create new docker image to output custom iso
docker build -t nanobox-boot2docker /vagrant/nanobox-b2d && \
# run custom docker image and capture output to iso
docker run --rm nanobox-boot2docker > /vagrant/nanobox-boot2docker.iso
SCRIPT

Vagrant.configure(2) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.box     = "nanobox/boot2docker"
  config.vm.box_url = "https://github.com/pagodabox/nanobox-boot2docker/releases/download/#{version}/nanobox-boot2docker.box"

  config.vm.synced_folder ".", "/vagrant"

  # wait for docker to be running
  config.vm.provision "shell", inline: $wait

  # Create custom iso
  config.vm.provision "shell", inline: $script

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "1500", "--ioapic", "on"]
  end

end
