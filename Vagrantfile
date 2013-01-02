# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Allow access to the VM's IP from host
  config.vm.network :bridged

  config.vm.share_folder "chef", "~/chef", "."
  config.vm.provision :shell, :inline => "cd chef && source bootstrap.sh"

end
