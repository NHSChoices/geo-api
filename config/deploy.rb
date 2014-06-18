set :application, 'geoapi'
set :repo_url, 'git@github.com:NHSChoices/geo-api.git'

set :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp } 

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/apps/geoapi'

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Install gems using bundler'
  after :publishing, :bundler do
    on roles(:app), in: :sequence, wait: 5 do
       execute "cd '#{release_path}' && source ~/.rbenvrc && bundle install"
    end
  end

  desc 'Restart geoapi app'
  after :bundler, :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "source ~/.rbenvrc && god restart geoapi"
    end
  end

end
