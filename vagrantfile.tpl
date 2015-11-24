Vagrant.configure("2") do |config|
  config.ssh.shell = "bash"
  config.ssh.username = "docker"
  config.ssh.password = "tcuser"

  # Attach the ISO
  config.vm.provider "virtualbox" do |v|
    v.customize "pre-boot", [
      "storageattach", :id,
      "--storagectl", "IDE Controller",
      "--port", "0",
      "--device", "1",
      "--type", "dvddrive",
      "--medium", File.expand_path("../nanobox-boot2docker.iso", __FILE__),
    ]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end
end
