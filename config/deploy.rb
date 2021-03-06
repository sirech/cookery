require "bundler/capistrano"

set :application, 'cookery'
set :repository,  'https://github.com/sirech/cookery.git'

set :thin_config, "/etc/thin.d/#{application}.yml"

set :scm, :git

set :user, 'sirech'
set :group, 'cook'
set :use_sudo, false

set :deploy_to, "/srv/www/#{application}"

default_run_options[:pty] = true

server 'erza', :app, :web, :db, :primary => true

# if you want to clean up old releases on each deploy uncomment this:
after 'deploy:restart', 'deploy:cleanup'

before "deploy:assets:precompile", "bundle:install"

after 'deploy:finalize_update', 'deploy:symlink_db'

namespace :deploy do
  desc 'Symlinks the database.yml'
  task :symlink_db, roles: :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end

  [:start, :stop].each do |t|
    task t do
      run "cd #{current_path} && bundle exec thin #{t} -C #{thin_config}"
    end
  end

  task :restart do
    stop
    start
  end
end
