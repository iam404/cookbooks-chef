# -*- mode: ruby -*-
# vi: set ft=ruby :
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
#sudo chef-client -z install_filebeat/recipes/default.rb 

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

$script = <<-SCRIPT
#!/bin/bash
#sudo apt-get update
wget -c https://packages.chef.io/files/stable/chef/12.16.42/ubuntu/12.04/chef_12.16.42-1_amd64.deb
sudo dpkg -i chef_12.16.42-1_amd64.deb
mkdir -p /var/chef/cookbooks
mount --bind /vagrant /var/chef/cookbooks
echo "cd /var/chef" >> /home/vagrant/.bashrc
SCRIPT

## Ubuntu 12.04 64 bit
config.vm.define "precise" do |precise|

  precise.vm.provider "virtualbox" do |v|
      v.memory = 1024
  end

  precise.vm.box = "ubuntu/precise64"
#  precise.vm.network "forwarded_port", guest: 80, host: 81
  precise.vm.network "private_network", ip: "192.168.33.12"
  precise.ssh.forward_agent = true
  precise.vm.provision "shell", inline: $script
end

end
