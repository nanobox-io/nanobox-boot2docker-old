Vagrant.configure("2") do |config|
  config.ssh.shell = "sh"
  config.ssh.username = "docker"

  # Expose the Docker port
  config.vm.network "forwarded_port", guest: 2375, host: 2375, host_ip: "127.0.0.1", auto_correct: true, id: "docker"

  # Attach the ISO
  config.vm.provider "virtualbox" do |v|
    v.customize "pre-boot", [
      "storageattach", :id,
      "--storagectl", "IDE Controller",
      "--port", "0",
      "--device", "1",
      "--type", "dvddrive",
      "--medium", File.expand_path("../pagoda-b2d.iso", __FILE__),
    ]
  end
end
