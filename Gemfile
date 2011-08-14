source 'http://rubygems.org'

# temporarily needed until next capybara release
gem 'selenium-webdriver', '0.2.1'

group :test do
  gem 'rspec-rails', '= 2.6.1'
  gem 'factory_girl', '= 1.3.3'
  gem 'factory_girl_rails', '= 1.0.1'
  gem 'rcov'
  gem 'shoulda'
  gem 'faker'
  if RUBY_VERSION < "1.9"
    gem "ruby-debug"
  else
    gem "ruby-debug19"
  end
end

gem 'spree', :git => 'git://github.com/spree/spree.git'
gem 'carrierwave'
gem 'rmagick'
gem 'spree_flexi_variants', :git => 'git://github.com/jsqu99/spree_flexi_variants.git'
gem 'sqlite3-ruby'
