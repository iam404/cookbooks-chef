#
# Cookbook Name:: install_maven
# Recipe:: default
#
# Copyright 2016,
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'ark'

ark 'maven' do
  version '3.0.5'
  url 'http://www-us.apache.org/dist/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.zip'
  prefix_bin '/usr/bin'
  home_dir '/usr/share/maven'
  append_env_path true
end

link "/usr/bin/mvn" do
to "/usr/share/maven/bin/mvn"
end

directory "#{ENV['HOME']}/.m2" do
  action :create
  recursive true
end

template "#{ENV['HOME']}/.m2/settings.xml" do
  source "settings.xml.erb"
  action :create
end

template "#{ENV['HOME']}/.m2/settings-security.xml" do
  source "settings-security.xml.erb"
  action :create
end

