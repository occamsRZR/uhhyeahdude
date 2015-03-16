set :application, 'uhhyeahdude'
set :repo_url, 'git@github.com:occamsRZR/uhhyeahdude.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }


# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{log tmp/pids tmp/sockets tmp/cache tmp/sockets vendor/bundle public/system public/assets}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
