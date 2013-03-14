default['user']                                   = 'vagrant'

# RBEnv
default['rbenv']['owner']                         = 'vagrant'
default['rbenv']['user_installs']                 = [{ 'user' => default['rbenv']['owner']}]

# PostgreSQL
default['postgresql']['database']['environments'] = %w(development test production)
default['postgresql']['pg_hba']                   = [
                                                    {:type => 'local', :db => 'all', :user => 'postgres', :addr => nil, :method => 'trust'},
                                                    {:type => 'local', :db => 'all', :user => 'all', :addr => nil, :method => 'trust'},
                                                    {:type => 'host', :db => 'all', :user => 'all', :addr => 'all', :method => 'trust'}
                                                  ]