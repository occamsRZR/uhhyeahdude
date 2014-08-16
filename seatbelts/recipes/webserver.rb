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
# run bundle install and rake db:setup in the context of the rvm gemset
#rvm_shell "bundle_and_setup_database" do
#  ruby_string "2.1.1@#{node.seatbelts.site_name}"
#  user node['seatbelts']['user']
#  cwd node['seatbelts']['deploy_path']
#  code %{bundle install && RAILS_ENV=#{node.seatbelts.rails_env} rake db:migrate}
  # only run if the database is present
#  only_if "psql -l | grep #{node.seatbelts.site_name}_#{node['seatbelts']['rails_env']} | wc -l"
#end


# wrapper for pumactl
rvm_wrapper node.seatbelts.site_name do
  ruby_string "2.1.1@#{node.seatbelts.site_name}"
  user node.seatbelts.user
  binary 'pumactl'
end


# wrapper for puma
rvm_wrapper node.seatbelts.site_name do
  ruby_string "2.1.1@#{node.seatbelts.site_name}"
  user node.seatbelts.user
  binary 'puma'
end

# wrapper for eye
rvm_wrapper node.seatbelts.site_name do
  ruby_string "2.1.1@#{node.seatbelts.site_name}"
  user node.seatbelts.user
  binary 'eye'
end

# eye server

eye_app "#{node.seatbelts.site_name}_puma" do
  enable true
  reload false
  restart false
  #template "uyd.conf.erb"
  variables :ruby => "#{node.rvm.default_ruby}"
end
