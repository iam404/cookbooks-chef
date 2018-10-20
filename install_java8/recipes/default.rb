###########---Java8---############


#Add java 8 apt repo
if File.exists?("/etc/apt/sources.d/webupd8team-java-trusty.list")
	log 'message' do
  		message 'Java8 3rd Party repo already added.'
  		level :info
  	end

else
	log 'message' do
  		message 'Installing and configuring Java8'
  		level :info
  	end

  	#should probably replace this with apt_repository, but it was having issues when I tried it the first go 'round'
  	bash 'add Java8 apt-repo' do
  		cwd ::File.dirname('/tmp')
  		code <<-EOH
    		sudo add-apt-repository 'ppa:webupd8team/java'
    		echo 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select' true | sudo /usr/bin/debconf-set-selections
    		sudo apt-get update
    		EOH
	end

	bash 'add Java8 apt-repo' do
  		cwd ::File.dirname('/tmp/')
  		code <<-EOH
    		echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
    	EOH
	end

	apt_package 'java8' do
  		package_name              'oracle-java8-installer'
  		action                     :install # defaults to :install if not specified
	end

	bash 'set Java8 as default' do
  		cwd ::File.dirname('/tmp/')
  		code <<-EOH
    		sudo update-java-alternatives -s java-8-oracle
    	EOH
	end

end

#Replace Java6 security policy files.
cookbook_file "/usr/lib/jvm/java-8-oracle/jre/lib/security/local_policy.jar" do
  source "local_policy.jar"
  mode "0644"
  action :create
end

cookbook_file "/usr/lib/jvm/java-8-oracle/jre/lib/security/US_export_policy.jar" do
  source "US_export_policy.jar"
  mode "0644"
  action :create
end
