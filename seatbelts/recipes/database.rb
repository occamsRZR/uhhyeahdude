#
# Cookbook Name:: seatbelts
# Recipe:: database
#
# Copyright (C) 2014 the42
# 
# All rights reserved - Do Not Redistribute
#
# The point of this recipe is to install and configure databases
#
# It includes the following packages:
#  - postgresql-client-9.3: client for accessing database
package 'postgresql-client-9.3'
package 'postgresql-contrib-9.3'
##
# PostgreSQL
include_recipe 'postgresql::server'
include_recipe 'database::postgresql'
postgresql_database_user 'postgres' do
  connection node['seatbelts']['psql_connection_info']
  password node['seatbelts']['postgres_password']
  action  :create
end
postgresql_database "#{node.seatbelts.site_name}_#{node.seatbelts.rails_env}" do
  connection node['seatbelts']['psql_connection_info']
  owner 'postgres'
  action :create
end
