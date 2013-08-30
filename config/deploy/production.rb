set :whenever_environment, 'production'
server "112.124.17.179", :app, :web, :db, :primary => true
set :user, "zcpdog"
set :rails_env, "production"
set :application, 'littlefire'
set :deploy_to,   "/home/zcpdog/var/www/apps/#{application}"
#set :branch,       "production"
set :db_user,        "root"
set :db_password,    "zcp@2746257"
set :db_encoding,    "utf8"
set :db_adapter,     "mysql2"
set :remote_db_name,  "#{application}_#{rails_env}"

set :aws_db_adapter, "mysql2"
set :aws_db_host, "54.213.111.253"
set :aws_db_user,  "root"
set :aws_db_password, "zcp@2746257"
set :aws_db_encoding, "utf8"
set :aws_db_port, "3306"
set :aws_db_database, "deal_factory"
set :aws_db_timeout,  "5000"

