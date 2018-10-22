#
# Cookbook Name:: enable-apt-cron-update
# Recipe:: default
#
# Copyright 2016, prabuddha.nike13@gmail.com
#
# All rights reserved - Do Not Redistribute
#

execute 'enabling apt cron' do
  command 'mv /etc/cron.daily/apt.disabled /etc/cron.daily/apt'
end
