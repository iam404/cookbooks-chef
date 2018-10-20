#
# Cookbook Name:: install_datadog
# Recipe:: default
#
#
# All rights reserved - Do Not Redistribute
#

script "install_something" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH

	DD_API_KEY="---PUT-DATADOG-API-KEY-HERE---" bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/dd-agent/master/packaging/datadog-agent/source/install_agent.sh)"

  EOH
end
