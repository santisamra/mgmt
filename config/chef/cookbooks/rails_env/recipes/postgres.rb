#
# Cookbook Name:: rails_env
# Recipe:: postgres
#
#   Copyright 2013 Wolox S.A.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
include_recipe "postgresql_server_utf8"
include_recipe "database::postgresql"

database = node['postgresql']['database']
database_user = (database['base'].nil? || database['base'].empty?)      ? database['user']      : database['base']
database_password = (database['base'].nil? || database['base'].empty?)  ? database['password']  : database['base']
database_base_name = (database['base'].nil? || database['base'].empty?) ? database['base_name'] : database['base']

postgresql_connection = {
  :host => 'localhost', 
  :port => 5432, 
  :username => 'postgres', 
  :password => node['postgresql']['password']['postgres']
}

# Creates database user
postgresql_database_user database_user do
  connection postgresql_connection
  password database_password
  privileges ["ALL"]
  action :create
end

# Creates databases for each enviroment
database['environments'].each do |env|
  postgresql_database "#{database_base_name}_#{env}" do
    connection postgresql_connection
    encoding 'UTF-8'
    owner database_user
    action :create
  end
end

bash "Grant createdb to #{database_user} user" do
  user "postgres"
  code "psql -c 'ALTER USER #{database_user} CREATEDB'"
end