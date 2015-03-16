workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup

environment ENV['RAILS_ENV'] || 'development'

bind 'unix://tmp/sockets/puma.sock'
pidfile 'tmp/pids/puma.pid'
state_path 'tmp/puma.state'

activate_control_app 'unix://tmp/sockets/pumactl.sock'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
