#
# Cookbook:: zabbix
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

yum_package %w(httpd httpd-devel mariadb mariadb-server php-fpm MySQL-python  php-mbstring php-pear php epel-release) do
    action :install
end


#rpm_package 'mysql-server' do
#  source 'http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm'
#  action :install
#end

#yum_package %w(mysql mysql-server) do
#  action :install
#end

#yum_package "php" do
 # action :install
#end

#yum_package %w(php php-cli php-common php-devel php-pear php-gd php-mbstring php-mysql php-xml) do
#action :install
#end

service 'httpd' do
 action :start 
end

service 'mariadb.service' do
 action :start 
end

rpm_package 'zabbix-repo' do
 source 'http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm'
  action :install
end

#yum_package 'zabbix-server-mysql' do
# action :install
#end

execute 'update' do 
command 'yum update -y'
end

#execute 'deltarpm' do
#command 'yum install deltarpm -y'
#end
#

yum_package 'zabbix-server-mysql' do
 action :install
end

yum_package 'zabbix-web-mysql' do
 action :install
end

yum_package 'zabbix-agent' do
 action :install
end

yum_package 'zabbix-java-gateway' do
 action :install
end

template "/etc/httpd/conf.d/zabbix.conf" do 
 source 'zabbix.conf.erb'
 mode '777'
   owner 'root'
   group 'root'
end

template "/etc/zabbix/web/zabbix.conf.php" do
 source 'zabbix.conf.php.erb'
  mode '777'
  owner 'root'
   group 'root'
end

template "/etc/zabbix/zabbix_server.conf" do
 source 'zabbix_server.conf.erb'
  mode '777'
  owner 'root'
   group 'root'
end




service 'httpd' do
 action :restart
end

include_recipe 'zabbix::mysql_secure_install'

service 'zabbix-server' do
 action :restart
end












