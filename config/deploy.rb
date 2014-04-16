set :application, 'geoapi'
set :repo_url, 'ssh://git@github.com/NHSChoices/geo-api.git'
set :deploy_via, :remote_cache

# Default branch is :master
set :branch, ENV['PUPPET_BRANCH'] || proc { `git rev-parse --abbrev-ref HEAD`.chomp } 

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/apps/geoapi'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Install gems using bundler'
  task :bundler do
    on roles(:app), in: :sequence, wait: 5 do
       # cd to releases dir and install modules using librarian-puppet - this
       # could be optimised by creating symlinks to it's .tmp / .librarian dir
       # into shared.
       execute "cd '#{release_path}' && bundle install"
    end
  end

  desc 'Restart geoapi app'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "god restart geoapi"
    end
  end

  before :publishing, :bundler
  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end