# ----------------------------------------
# Installing filebeat and configuring it
#-----------------------------------------

bash 'install filebeat service' do
  user 'root'
  cwd '/tmp'
  code <<-EOH

  if [ -f /etc/filebeat/filebeat.yml ]; then
      filebeat version | grep -w "filebeat version 6.2.4"
      if [ $? -ne 0 ]; then
         echo "Old filebeat version found. Removing ..."
         apt-get purge -y filebeat
         rm -rf /etc/filebeat
         echo "Installing current filebeat version"
         curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.4-amd64.deb
         sudo dpkg -i filebeat-6.2.4-amd64.deb
         rename 's/\.yml.disabled$/\.yml/' /etc/filebeat/modules.d/*.disabled
      fi
  else
     echo "Installing filebeat 6.2.4"
     curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.4-amd64.deb
     sudo dpkg -i filebeat-6.2.4-amd64.deb
     rename 's/\.yml.disabled$/\.yml/' /etc/filebeat/modules.d/*.disabled
  fi

  EOH
end

execute "sudo mkdir -p /etc/filebeat/conf.d"

# Copy over the filebeat.yml.
template "/etc/filebeat/filebeat.yml" do
  source "filebeat.yml"
  action :create
end

# Copy over the filebeat.yml.
template "/etc/filebeat/conf.d/#{node[:application]}.yml" do
  source "conf.d/#{node[:application]}.yml"
  action :create
  ignore_failure true
end

# ----------------------------------------
# restarting filebeat service
#-----------------------------------------
execute "sudo service filebeat restart"