set :whenever_environment, 'production'
server "106.186.18.91", :web, :db, :app, :primary => true
set :user, "littlefire"
set :rails_env, "production"
set :application, 'littlefire'
set :deploy_to,   "/home/littlefire/var/www/apps/#{application}"
set :db_user,        "root"
set :db_password,    "zcp@4762832"
set :db_encoding,    "utf8"
set :db_adapter,     "mysql2"
set :db_pool,         "10"
set :remote_db_name,  "#{application}_#{rails_env}"

set :aws_db_adapter,   "mysql2"
set :aws_db_host,    "54.213.111.253"
set :aws_db_user,     "root"
set :aws_db_password,  "zcp@2746257"
set :aws_db_encoding,  "utf8"
set :aws_db_port,  "3306"
set :aws_db_database,  "deal_factory"
set :aws_db_timeout,  "5000"

