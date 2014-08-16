#
# Cookbook Name:: seatbelts
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

##
# Give sudo permissions to the user
include_recipe 'sudo'
sudo node['seatbelts']['user'] do
  user node['seatbelts']['user']
  runas node['seatbelts']['user']
end

# create user, set shell and folder
user node['seatbelts']['user'] do
  password node['seatbelts']['password']
  shell '/bin/zsh'
  home "/home/#{node['seatbelts']['user']}"
end

# make the seatbelts user's directory available to the gita group
directory "/home/#{node['seatbelts']['user']}" do
  owner node['seatbelts']['user']
  mode 0774
end

# need to have a swap or else the free image doesn't like it
swap_file '/mnt/swap' do
  size      1024    # MBs
end
