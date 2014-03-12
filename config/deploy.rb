require "rvm/capistrano"
require "bundler/capistrano"
require 'capistrano/ext/multistage'
require 'sidekiq/capistrano'
require "whenever/capistrano"

set :whenever_command, "bundle exec whenever"
set :stages, ["staging", "production"]
set :default_stage, "staging"
default_run_options[:pty] = true
set :application, "littlefire"
set :repository,  "git@bitbucket.org:zcpdog/littlefire.git"
set :deploy_via, :remote_cache
set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :use_sudo, false
set :keep_releases, 3
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"
after "deploy:setup", "deploy:create_database_yaml"
before "deploy:assets:precompile", "deploy:config_symlink"
after "deploy:create_symlink", "deploy:migrate"

namespace :deploy do
  desc "Creates database.yml for project/branch"
  task :create_database_yaml do
    sudo "mkdir -p #{shared_path}/config"
    sudo "chown #{user}:#{user} #{shared_path}/config"
    db = {"#{rails_env}" => {'adapter' => db_adapter, 'encoding' => db_encoding, 
        'database' => "#{remote_db_name}", 'username' => db_user, 'password' => db_password}}
    put db.to_yaml, "#{shared_path}/config/database.yml"
  end
  
  desc "copy database.yml to /current_release/config"
  task :config_symlink do
    run "ln -nsf #{shared_path}/config/database.yml #{current_release}/config"
    #run "ln -nsf #{shared_path}/log/production.log #{current_release}/log/production.log"
  end
  
  task :restart do
    sudo "/opt/nginx/sbin/nginx -s reload"
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end
  
  task :reindex do
    run "cd #{current_path} && #{rake} RAILS_ENV=#{rails_env} sunspot:solr:reindex" 
  end
end

desc 'copy ckeditor nondigest assets'
task :copy_nondigest_assets, roles: :app do
  run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} ckeditor:create_nondigest_assets"
end
after 'deploy:assets:precompile', 'copy_nondigest_assets'

namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run_locally "RAILS_ENV=#{rails_env.to_s.shellescape} #{asset_env} #{rake} assets:precompile"
        local_manifest_path = run_locally "ls public/assets/manifest*"
        local_manifest_path.strip!
        servers = find_servers :roles => assets_role, :except => { :no_release => true }
        run "cd #{shared_path}/assets && rm -f manifest*"
        servers.each do |srvr|
          run_locally "rsync -av public/assets #{user}@#{srvr}:#{shared_path}"
          run_locally "rsync -av #{local_manifest_path} #{user}@#{srvr}:#{release_path}/assets_manifest#{File.extname(local_manifest_path)}"
        end
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end
end

# namespace :solr do                                                              
#   task :reindex do
#     run "cd #{current_path} && #{rake} RAILS_ENV=#{rails_env} sunspot:solr:reindex" 
#   end
# end 
#after "deploy:restart", "solr:reindex"

# namespace :delayed_job do
#   desc "Start delayed_job process"
#   task :start, :roles => :app do
#     run "cd #{current_path}; RAILS_ENV=#{rails_env} bin/delayed_job start "
#   end
#   
#   desc "Stop delayed_job process"
#   task :stop, :roles => :app do
#     run "cd #{current_path}; RAILS_ENV=#{rails_env} bin/delayed_job stop "
#   end
# 
#   desc "Restart delayed_job process"
#   task :restart, :roles => :app do
#     run "cd #{current_path}; RAILS_ENV=#{rails_env} bin/delayed_job restart"
#   end
# end

# after "deploy:start", "delayed_job:start"
# after "deploy:stop", "delayed_job:stop"
# after "deploy:restart", "delayed_job:restart"


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end