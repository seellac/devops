#
# Cookbook Name:: session_apache
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'httpd' do
end

directory '/work' do
  owner 'root'
  group 'root'
  mode '755'
  action :create
end

cron "testjob" do
  minute '0'
  hour   '*/5'
  day    '*'
  month  '*'
  weekday '*'
  command "echo"
  action  :create
end

user 'test' do
  uid '1234'
  home '/home/test'
  action :create
end

cookbook_file '/var/www/html/index.html' do
  source "index.html"
  mode "0644"
end

puts "We are checking session_apache cookbook port"

apache_port = "#{node['session_apache']['port']}"

puts "Apache port is: #{apache_port}"

template "/etc/httpd/conf/httpd.conf" do
  source "httpd.conf.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  variables :apache_port => apache_port
end

service "httpd" do
  action [:enable, :start]
end
