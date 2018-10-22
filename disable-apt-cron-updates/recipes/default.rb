#
# Cookbook Name:: disable-apt-cron-update
# Recipe:: default


execute 'disabling apt cron' do
  command 'mv /etc/cron.daily/apt /etc/cron.daily/apt.disabled'
end
