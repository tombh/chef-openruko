#!/bin/bash

PATH=$PATH:/var/lib/gems/1.9.1/bin

chef_version="10.16.4"

# Are we on a vanilla system?
if (! command -v chef-solo >/dev/null 2>&1) || (! chef-solo --version | grep $chef_version); then
    export DEBIAN_FRONTEND=noninteractive
    # Upgrade headlessly (this is only safe-ish on vanilla systems)
    sudo aptitude update &&
    sudo apt-get -o Dpkg::Options::="--force-confnew" \
      --force-yes -fuy dist-upgrade &&
    # Install Ruby and Chef
    sudo aptitude install -y ruby1.9.1 ruby1.9.1-dev make &&
    sudo gem1.9.1 install --no-rdoc --no-ri chef --version $chef_version &&
    sudo useradd -d /home/rukosan -m rukosan -s /bin/bash -c Rukosan &&
    sudo su - -c "echo \"rukosan ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers"
fi &&

sudo chef-solo -c solo.rb -j solo.json && exit 0
