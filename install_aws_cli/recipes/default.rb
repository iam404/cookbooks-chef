#
# Cookbook Name::install_aws_cli
# Recipe:: default
#
# Copyright 2016, prabuddha.nike13@gmail.com
#
# All rights reserved - Do Not Redistribute
#
# Installs of awscli but does not configure credentials

#install python , zip and other necesseary packages
include_recipe 'install_other_packages::default'

#install  pip 
execute "apt-get --assume-yes install python-pip"

#intall awscli
bash "download and unpack perfmon agent" do
        cwd "/home/ubuntu"
        code <<-EOH
        wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
        unzip awscli-bundle.zip
        sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
        rm -rf awscli-bundle*
        EOH
end