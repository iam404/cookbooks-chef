#
# Cookbook Name:: install_java6
# Recipe:: default
#
#
# All rights reserved - Do Not Redistribute
#
# Installs Java 6 update 45


# Make a folder for Java to live in.
execute "mkdir -p /usr/lib/jvm" do
  not_if do File.exists?("/usr/lib/jvm/jre1.6.0_45/java") end
end

# Copy over the Java 6 SDK installer
cookbook_file "/usr/lib/jvm/jdk-6u45-linux-x64.bin" do
  source "jdk-6u45-linux-x64.bin"
  action :create_if_missing
  not_if do File.exists?("/usr/lib/jvm/jre1.6.0_45/java") end
end

# Copy over the Java 6 JRE installer
cookbook_file "/usr/lib/jvm/jre-6u45-linux-x64.bin" do
  source "jre-6u45-linux-x64.bin"
  action :create_if_missing
  not_if do File.exists?("/usr/lib/jvm/jre1.6.0_45/java") end
end

# Make the binaries executable
execute "chmod u+x /usr/lib/jvm/jdk-6u45-linux-x64.bin" do
  not_if do File.exists?("/usr/lib/jvm/jre1.6.0_45/java") end
end
execute "chmod u+x /usr/lib/jvm/jre-6u45-linux-x64.bin" do
  not_if do File.exists?("/usr/lib/jvm/jre1.6.0_45/java") end
end

# Extract the binaries
execute "cd /usr/lib/jvm/ && ./jdk-6u45-linux-x64.bin" do
  not_if do File.exists?("/usr/lib/jvm/jre1.6.0_45/java") end
end
execute "cd /usr/lib/jvm/ && ./jre-6u45-linux-x64.bin" do
  not_if do File.exists?("/usr/lib/jvm/jre1.6.0_45/java") end
end

# Update Ubuntu's information about Java
execute "update-alternatives --install \"/usr/bin/java\" \"java\" \"/usr/lib/jvm/jre1.6.0_45/bin/java\" 1" do
  not_if do File.exists?("/usr/lib/jvm/jre1.6.0_45/java") end
end
execute "update-alternatives --install \"/usr/bin/javac\" \"javac\" \"/usr/lib/jvm/jdk1.6.0_45/bin/javac\" 1" do
  not_if do File.exists?("/usr/lib/jvm/jre1.6.0_45/java") end
end
execute "sudo update-alternatives --set java /usr/lib/jvm/jre1.6.0_45/bin/java" do
  not_if do File.exists?("/usr/lib/jvm/jre1.6.0_45/java") end
end
execute "sudo update-alternatives --set javac /usr/lib/jvm/jdk1.6.0_45/bin/javac" do
  not_if do File.exists?("/usr/lib/jvm/jre1.6.0_45/java") end
end


#Replace Java6 security policy files. See https://stackoverflow.com/questions/6481627/java-security-illegal-key-size-or-default-parameters
cookbook_file "/usr/lib/jvm/jdk1.6.0_45/jre/lib/security/local_policy.jar" do
  source "local_policy.jar"
  mode "0644"
  action :create
end

cookbook_file "/usr/lib/jvm/jdk1.6.0_45/jre/lib/security/US_export_policy.jar" do
  source "US_export_policy.jar"
  mode "0644"
  action :create
end

cookbook_file "/usr/lib/jvm/jre1.6.0_45/lib/security/local_policy.jar" do
  source "local_policy.jar"
  mode "0644"
  action :create
end

cookbook_file "/usr/lib/jvm/jre1.6.0_45/lib/security/US_export_policy.jar" do
  source "US_export_policy.jar"
  mode "0644"
  action :create
end

#Add JAI jars to jdk

cookbook_file "/usr/lib/jvm/jdk1.6.0_45/jre/lib/ext/jai_codec-1.1.3.jar" do
  source "jai_codec-1.1.3.jar"
  mode "0644"
  action :create
end

cookbook_file "/usr/lib/jvm/jre1.6.0_45/lib/ext/jai_core.jar" do
  source "jai_core.jar"
  mode "0644"
  action :create
end

cookbook_file "/usr/lib/jvm/jre1.6.0_45/lib/ext/jai_imageio-1.1.jar" do
  source "jai_imageio-1.1.jar"
  mode "0644"
  action :create
end
