# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "openruko"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Allow access to the VM's IP from host
  config.vm.network :bridged

  #  For i686 prefer a 32bit VM
  #  config.vm.box = "openruko32"
  #  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  config.vm.share_folder "chef", "~/chef", "."
  config.vm.provision :shell, :inline => "cd chef && source bootstrap.sh"
end

# If you want to do some funky custom stuff to your box, but don't want those things tracked by git,
# add a Vagrantfile.local and it will be included. For example you could mount your dev version of
# slotbox with;
# config.vm.share_folder "slotbox", "/home/rukosan/slotbox_mount", "~/Software/slotbox"
# Then symlink the various repos you're hacking on to see changes straight away on the live box.
require "Vagrantfile.local" if File.exists? "Vagrantfile.local"