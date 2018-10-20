# ----------------------------------------
# Installing filebeat and configuring it
#-----------------------------------------

bash 'install filebeat service' do
  user 'root'
  cwd '/tmp'
  code <<-EOH

  if [ -f /etc/metricbeat/metricbeat.yml ]; then
      metricbeat version | grep -w "metricbeat version 6.2.4"
      if [ $? -ne 0 ]; then
         echo "Old Metricbeat version found. Removing ..."
         apt-get purge -y metricbeat
         rm -rf /etc/metricbeat
         echo "Installing current metricbeat version"
         curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.2.4-amd64.deb
         sudo dpkg -i metricbeat-6.2.4-amd64.deb
         mv /etc/metricbeat/modules.d /etc/metricbeat/modules.d.original
         mkdir /etc/metricbeat/modules.d
        ### rename 's/\.yml.disabled$/\.yml/' /etc/metricbeat/modules.d/*.disabled
      fi
  else
     echo "Installing metricbeat 6.2.4"
     curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.2.4-amd64.deb
     sudo dpkg -i metricbeat-6.2.4-amd64.deb
     mv /etc/metricbeat/modules.d /etc/metricbeat/modules.d.original
     mkdir /etc/metricbeat/modules.d
  fi

  EOH
end


# Copy over the metricbeat.yml.
template "/etc/metricbeat/metricbeat.yml" do
  source "metricbeat.yml"
  action :create
end

# Copy over the metricbeat modules .
template "/etc/metricbeat/modules.d/system.yml" do
  source "modules.d/system.yml"
  action :create
end

# Copy over the metricbeat modules .
template "/etc/metricbeat/modules.d/#{node[:application]}.yml" do
  source "modules.d/#{node[:application]}.yml"
  action :create
  ignore_failure true
end

# ----------------------------------------
# restarting metricbeat service
#-----------------------------------------
execute "sudo service metricbeat restart"