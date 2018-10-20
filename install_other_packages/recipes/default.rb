#
# Cookbook Name:: install_other_packages
# Recipe:: default
#
# Copyright 2013, Health Fidelity
#
# All rights reserved - Do Not Redistribute
#
# Install other packages required by the REVEAL software.

execute "apt-get --assume-yes --force-yes install ssh unzip zip mc dos2unix python-software-properties" do end

# Installing font-config
execute "apt-get --assume-yes --force-yes install fontconfig" do end

# Installing MS specific fonts
execute "apt-get --assume-yes --force-yes install ttf-mscorefonts-installer" do end

execute "apt-get --assume-yes --force-yes install fonts-cantarell lmodern ttf-aenigma ttf-georgewilliams ttf-bitstream-vera ttf-sjfonts ttf-tuffy tv-fonts" do end

execute "apt-get --assume-yes --force-yes install ubuntustudio-font-meta" do end


# installing tahoma font

cookbook_file "/home/ubuntu/tahoma.zip" do
  source "tahoma.zip"
  mode "0755"
  action :create
end

execute "cd /home/ubuntu && unzip -o -d /usr/share/fonts/truetype/msttcorefonts tahoma.zip" do end

execute "fc-cache -f -v" do end

execute "rm -rf /home/ubuntu/tahoma.zip" do end

#add cmd line json parser to bin
bash "download and install jq" do
  cwd "/usr/bin/"
  code <<-EOH
  wget http://stedolan.github.io/jq/download/linux64/jq
  chmod 751 jq
  EOH
end