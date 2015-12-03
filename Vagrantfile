# -*- mode: ruby -*-
# vi: set ft=ruby :

$wait = <<SCRIPT
echo "Waiting for docker sock file"
while [ ! -S /var/run/docker.sock ]; do
  sleep 1
done
SCRIPT

$script = <<SCRIPT
# fetch nanobox custom boot2docker ISO spitter-outer
docker pull nanobox/boot2docker
# run custom docker image and capture output to iso
docker run nanobox-boot2docker > /vagrant/nanobox-boot2docker.iso
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.box = "mitchellh/boot2docker"

  config.vm.synced_folder ".", "/vagrant"

  # wait for docker to be running
  config.vm.provision "shell", inline: $wait

  # Create custom iso
  config.vm.provision "shell", inline: $script

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "1500", "--ioapic", "on", "--cpus", "2"]
  end

end
