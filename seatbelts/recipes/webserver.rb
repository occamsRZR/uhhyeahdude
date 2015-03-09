#
# Cookbook Name:: seatbelts
# Recipe:: webserver
#
# Copyright (C) 2014 the42
# 
# All rights reserved - Do Not Redistribute
#
# The point of this recipe is to install and configure databases
#
# It includes the following packages:
#  - nginx: what serves the content
#  - 
include_recipe 'nginx'
nginx_site 'default' do
  enable false
end

template "#{node['nginx']['dir']}/sites-available/#{node['seatbelts']['site_name']}" do
  source 'nginx-puma.erb'
  notifies :restart, 'service[nginx]'
end
nginx_site "#{node.seatbelts.site_name}" do
  template 'nginx-puma.erb'
end

include_recipe 'rvm'
