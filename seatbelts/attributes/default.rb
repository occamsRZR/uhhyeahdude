default['seatbelts']['user'] = 'ubuntu'
default['seatbelts']['site_name'] = 'uyd-archives'
default['seatbelts']['deploy_path'] = "/home/#{node['seatbelts']['user']}/#{node['seatbelts']['site_name']}/current"

default['oh_my_zsh'][:users] = [{
	login: 'root',
	theme: 'gnzh',
	plugins: ['gem', 'git', 'rails', 'redis-cli', 'rvm', 'bundler', 'debian']
}]
default['seatbelts']['psql_connection_info'] = {
	host: 'localhost',
	username: 'postgres',
	password: 'toor'
}
default['seatbelts']['mysql_connection_info'] = {
	host: 'localhost',
	username: 'root',
	password: 'toor'
}
default['mysql']['server_root_password'] = 'toor'

# RVM
default['rvm']['branch'] = 'none'
default['rvm']['rvm_gem_options'] = '--no-rdoc --no-ri'
default['rvm']['user_installs'] = [
	{
		user: node['seatbelts']['user']
	}
]

# WEBSERVER
default['nginx']['user'] = node['seatbelts']['user']
default['nginx']['enable_default_site'] = false
default['languages']['ruby']['bin_dir'] = node.rvm.default_ruby
# DATABASE
default['postgresql']['version'] = '9.3'
default['postgresql']['password'] = {
  postgres: 'toor'
}
default['postgresql']['pg_hba'] = [
          {
            :comment => '# md5 password auth for any address',
            :type => 'host',
            :db => 'all', 
            :user => 'postgres',
            :addr => '0.0.0.0/0', 
            :method => 'md5'
          },{
            :comment => '# local socket connections',
            :type => 'local',
            :db => 'all', 
            :user => 'all',
            :addr => nil, 
            :method => 'trust'
          },{
            :comment => '# localhost connections',
            :type => 'host',
            :db => 'all', 
            :user => 'all',
            :addr => '127.0.0.1/32', 
            :method => 'trust'
          },{
            :comment => '# I think this is IPv6',
            :type => 'host',
            :db => 'all', 
            :user => 'all',
            :addr => '::1/128', 
            :method => 'md5'
          }
]
