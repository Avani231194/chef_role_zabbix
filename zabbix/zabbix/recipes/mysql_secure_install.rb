bash 'extract_module' do
  code <<-EOH
mysql -u root -e " CREATE DATABASE zabbix;"
mysql -u root -e "GRANT ALL PRIVILEGES on zabbix.* to zabbix@localhost IDENTIFIED BY 'root';"
mysql -u root -e "FLUSH PRIVILEGES;"
EOH
end

bash 'extract data' do
cwd '/usr/share/doc/zabbix-server-mysql-3.2.7'
code <<-EOH
zcat create.sql.gz | mysql -uroot zabbix 
EOH
end
