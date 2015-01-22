Uhh Yeah Dude Archives
================

This is the repository for http://archive.uhhyeahdu.de

It is written with Ruby on Rails

Ruby on Rails
-------------

This application requires:

- Ruby 2.1.1
- Rails 4.1.4


Getting Started
---------------

Before setting up your vagrant box, be sure to download the following:

- the [latest version of VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- the [latest version of Vagrant](http://www.vagrantup.com/downloads.html)
- the [latest version of Chef Development Kit](http://downloads.getchef.com/chef-dk/)

First, we'll need to go to the directory with the vagrant configuration:

	cd seatbelts/

We need to run the following commands to get all of the needed plugins.

	vagrant plugin install vagrant-berkshelf --plugin-version=3.0.1
	vagrant plugin install hashie --plugin-version '< 3.0'
	vagrant plugin install vagrant-omnibus

We can then boot up our vagrant box:

	vagrant up uyd-dev

The box should be provisioned for you.  If there were some provisioning changes since you `vagrant up`'d the box, we will need to provision:

	vagrant provision uyd-dev

If this step completed without errors, you should be able to `ssh` into the box.

	vagrant ssh uyd-dev

The project is located at `/home/vagrant/uyd/` on the vagrant box.  Go to that directory and prepare the app.

	cd uyd/current

Now you are ready to bundle and setup the database.

	bundle install
	rake db:setup
	
You can now launch the server with `rails s` to start puma.  You can access the box at `33.33.33.6:3000`
