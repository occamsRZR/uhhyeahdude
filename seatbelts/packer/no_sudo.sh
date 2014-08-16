#!/bin/bash

# Setup sudo to allow no-password sudo for "admin"
echo 'vagrant' | sudo -S groupadd -r admin
echo 'vagrant' | sudo -S usermod -a -G admin vagrant
echo 'vagrant' | sudo -S cp /etc/sudoers /etc/sudoers.orig
echo 'vagrant' | sudo -S sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
echo 'vagrant' | sudo -S sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers

wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/13.04/x86_64/chef_11.12.0-1_amd64.deb > ~/chef.deb
curl -L https://www.opscode.com/chef/install.sh | sudo bash