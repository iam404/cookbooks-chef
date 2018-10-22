#
# Cookbook Name:: unattended-upgrades


include_recipe 'apt'

package 'unattended-upgrades'


if node['unattended-upgrades']['admin_email']
  apt_package "mailutils" do
      action :install
  end
end

template '/etc/apt/apt.conf.d/50unattended-upgrades' do
  source 'unattended-upgrades.conf.erb'
  owner 'root'
  group 'root'
  mode  '0644'
  variables(
    :allowed_origins            => node['unattended-upgrades']['allowed_origins'],
    :package_blacklist          => node['unattended-upgrades']['package_blacklist'],
    :autofix_dpkg               => node['unattended-upgrades']['autofix_dpkg'],
    :minimal_steps              => node['unattended-upgrades']['minimal_steps'],
    :install_on_shutdown        => node['unattended-upgrades']['install_on_shutdown'],
    :admin_email                => node['unattended-upgrades']['admin_email'],
    :mail_only_on_error         => node['unattended-upgrades']['mail_only_on_error'],
    :remove_unused_dependencies => node['unattended-upgrades']['remove_unused_dependencies'],
    :automatic_reboot           => node['unattended-upgrades']['automatic_reboot'],
    :download_limit             => node['unattended-upgrades']['download_limit']
  )
end

template '/etc/apt/apt.conf.d/20auto-upgrades' do
  source 'auto-upgrades.conf.erb'
  owner 'root'
  group 'root'
  mode  '0644'
  variables(
    :update_package_lists_interval => node['unattended-upgrades']['update_package_lists_interval'],
    :upgrade_interval              => node['unattended-upgrades']['upgrade_interval'],
    :download_upgradeable_interval => node['unattended-upgrades']['download_upgradeable_interval'],
    :autoclean_interval            => node['unattended-upgrades']['autoclean_interval'],
  )
end
