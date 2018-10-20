#
# Cookbook Name:: install_cloudwatch_agent
# Recipe:: default
#
# Copyright 2016, prabuddha.nike13@gmail.com
#
# All rights reserved - Do Not Redistribute
#

####### Pre-Reqs #########

#Install Pip for Python

#apt_package 'python-pip' do
#  action :install
#end


#Install awscli via pip
#execute 'Install awscli via pip' do
#  command 'pip install awscli'
#  user 'root'
#end


# New Process for installing Python PIP and AWS-CLI

execute "

cd /tmp
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py


pip install cheetah
pip install testresources
pip install awscli

aws --version

" do end






#Create /root/bin directory
directory '/root/bin' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

##### Install CloudWatch Agent ######

#Get CloudWatch agent
remote_file '/tmp/awslogs-agent-setup.py' do
  source 'https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

#Install CloudWatch Agent
execute 'Install CloudWatch Agent' do
  command '/tmp/awslogs-agent-setup.py -n -r us-west-1 -c s3://cloudwatch-hfprod/awslogs.conf'
  user 'root'
end

#### Copy Shell Script ######

#Copy refresh bash script
cookbook_file '/root/bin/refresh_awslogs' do
  source 'refresh_awslogs'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

#Run bash script
execute 'Execute Refresh_awslogs script' do
  command '/root/bin/refresh_awslogs'
  user 'root'
end



