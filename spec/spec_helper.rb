# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'


require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'

#include spree's factories
require 'spree_core'

# need this b/c of controllers/spree/admin/users_controller.
# it has a reference to User::DestroyWithOrdersError, and we only have a spree_core dependency in our gemspec.  This smells...must bring this up on spree group
#class Spree::User::DestroyWithOrdersError < StandardError; end
#require 'spree_core/testing_support/factories'

# include local factories
Dir["#{File.dirname(__FILE__)}/factories/**/*.rb"].each do |f|
  fp =  File.expand_path(f)
  require fp
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each {|f| require f }

# Requires factories defined in spree_core
require 'spree/core/testing_support/factories'

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.

  config.use_transactional_fixtures = false


#  config.before(:suite) do
#    DatabaseCleaner.strategy = :truncation
#  end
#
#  config.before(:each) do
#    DatabaseCleaner.start
#  end
#
#  config.after(:each) do
#    DatabaseCleaner.clean
#  end


  # https://groups.google.com/forum/m/#!msg/ruby-capybara/JI6JrirL9gM/R6YiXj4gi_UJ

  class ActiveRecord::Base
    mattr_accessor :shared_connection
    @@shared_connection = nil

    def self.connection
      @@shared_connection || retrieve_connection
    end
  end

  # Forces all threads to share the same connection. This works on
  # Capybara because it starts the web server in a thread.
  ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

end
