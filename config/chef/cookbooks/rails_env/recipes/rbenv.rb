#
# Cookbook Name:: rails_env
# Recipe:: rbenv
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
include_recipe 'ruby_build'
include_recipe 'rbenv::user_install'

version     = node['ruby']['version']
rbenv_user  = node['rbenv']['owner']

rbenv_ruby version do
  user rbenv_user
  action :install
end

rbenv_global version do
  user rbenv_user
  action :create
end

rbenv_gem "bundler" do
  rbenv_version   version
  user rbenv_user
  action :install
end