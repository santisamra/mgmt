#
# Cookbook Name:: rails_env
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "set_locale"
include_recipe "imagemagick"
include_recipe "imagemagick::devel"

package "tree"
package "vim"
package "libxml2-dev"
package "libxslt1-dev"
package "wget"

################### Setting up PostgresSQL databases ###########################
include_recipe "postgresql_server_utf8"
include_recipe "database::postgresql"

database = node['postgresql']['database']
postgresql_connection = {
  :host => 'localhost', 
  :port => 5432, 
  :username => 'postgres', 
  :password => 'postgres'
}

# Creates database user
postgresql_database_user database['user'] do
  connection postgresql_connection
  password database['password']
  privileges ["ALL"]
  action :create
end

# Creates databases for each enviroment
database['environments'].each do |env|
  postgresql_database "#{database['base_name']}_#{env}" do
    connection postgresql_connection
    encoding 'UTF-8'
    owner database['user']
    action :create
  end
end

bash "Grant createdb to #{database['user']} user" do
  user "postgres"
  code "psql -c 'ALTER USER #{database['user']} CREATEDB'"
end
################################################################################

################################# Install Ruby #################################
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby node['ruby']['version'] do
  global true
end

rbenv_gem "bundler" do
  ruby_version node['ruby']['version']
end

bash "Change rbenv to vagrant" do
  code "chown -R #{node['rbenv']['owner']}:#{node['rbenv']['owner']} /opt/rbenv"
end
################################################################################


################################ Install phantomjs ##############################
# package "fontconfig"
# package "libfreetype6"
# package "libfreetype6-dev"
# bash "install PhantomJS" do
#   code <<-BASH
#   if test ! $(which phantomjs)
#   then
#     wget http://phantomjs.googlecode.com/files/phantomjs-1.8.0-linux-x86_64.tar.bz2
#     tar -xf phantomjs-1.8.0-linux-x86_64.tar.bz2
#     mv phantomjs-1.8.0-linux-x86_64 /usr/local/phantomjs
#     ln -s /usr/local/phantomjs/bin/phantomjs /usr/local/bin/phantomjs
#     rm -rf phantomjs-1.8.0-linux-x86_64*
#   fi
#   BASH
# end
################################################################################