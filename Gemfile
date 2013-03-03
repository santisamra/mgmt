source 'https://rubygems.org'

gem 'rails', '3.2.12'

gem 'pg'
gem 'github_api'
gem 'haml-rails'
gem 'jquery-rails'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
end

group :test, :development do
  # Debugging
  gem 'pry'
  gem 'debugger'
  gem 'debugger-pry'
  gem 'pry-nav'
  gem 'pry-stack_explorer'

  # Testing
  gem 'timecop'
  gem 'rspec-rails', '~>2.11.0'
  gem 'shoulda-matchers', '~>1.4.2'
  gem 'factory_girl_rails', '~>4.1.0'
  gem 'faker', '~>1.1.2'
  # gem 'cucumber-rails', '~>1.3.0', :require => false
  gem 'database_cleaner', '~>0.9.1'
end