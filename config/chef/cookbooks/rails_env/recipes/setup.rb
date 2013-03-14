include_recipe "set_locale"

template "/home/#{node['user']}/.bashrc" do
  source "bashrc.erb"
  mode 0644
  owner node['user']
  group node['user']
end