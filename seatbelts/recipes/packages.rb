#
# Cookbook Name:: seatbelts
# Recipe:: packages
#
# Copyright (C) 2014 the42
# 
# All rights reserved - Do Not Redistribute
#
# The point of this recipe is to install and configure packages 
# that are useful for server maintenance and default functionality.
#
# It includes the following packages:
#  - htop: used for process monitoring
#  - oh_my_zsh: installs zsh and plugins
#  - rvm: ruby version manager
#  - imagemagick: for image processing
include_recipe 'apt::default'

##
execute 'apt-get update' do
  action :nothing
end.run_action(:run)

##
# install packages
package 'htop'
package 'emacs24'
package 'redis-server'
##
# oh my zsh, rvm, and imagemagick
include_recipe 'oh_my_zsh'
include_recipe 'rvm::user'
include_recipe 'rvm::system_install'
include_recipe 'imagemagick'

rvm_ruby 'ruby-2.1.5' do
  action :install
end
# needed for a gem
package 'libcurl4-openssl-dev'
