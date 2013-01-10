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

# If you want to do some funky custom stuff to your box, but don't want those things tracked by git,
# add a Vagrantfile.local and it will be included. For example you could mount your dev version of
# openruko with;
# config.vm.share_folder "openruko", "/home/rukosan/openruko_mount", "~/Software/openruko"
# Then symlink the various repos you're hacking on to see changes straight away on the live box.
load "./Vagrantfile.local" if File.exists? "Vagrantfile.local"
