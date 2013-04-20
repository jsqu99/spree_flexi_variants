source 'http://rubygems.org'

gem 'spree', '~> 1.3.2'

# TODO: uncomment when https://github.com/spree/spree_auth_devise/issues/53 is resolved
# gem version 1.3.1 isn't really 1.3.1
#gem 'spree_auth_devise', '~> 1.3.1'
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '1-3-stable'

gem 'spree_landlord', github: 'jsqu99/spree_landlord', branch: 'deface_integration'

if RUBY_VERSION < "1.9"
  gem "ruby-debug"
else
  gem "ruby-debug19"
end

group :test do
  gem 'rspec-rails', '2.12.0'
  gem 'sqlite3'
  gem 'factory_girl_rails', '~> 1.7.0'
  gem 'ffaker'
  gem 'capybara', '2.0.2'
  gem 'launchy'
  gem 'pry'
end

group :assets do
  gem 'coffee-rails'
end
gemspec
