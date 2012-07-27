set :stages, %w(staging production)
set :default_stage, "production"
require 'capistrano/ext/multistage'

set :application, "100k"
set :repository,  "git@github.com:nyconrails/100k.git"
set :user, "railsapps"
set :use_sudo, false
set :deploy_to, "/home/railsapps/public_html/#{application}"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set(:domain) { "#{domain}" }
role(:web) { domain }
role(:app) { domain }
role :db,  "69.55.62.60"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

load 'deploy/assets'

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
