set :application, 'cookery'
set :repository,  'https://github.com/sirech/cookery.git'

set :scm, :git

set :user, 'sirech'
set :use_sudo, false

set :deploy_to, "/srv/www/#{application}"

default_run_options[:pty] = true

server 'erza', :app, :web, :db, :primary => true

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"
