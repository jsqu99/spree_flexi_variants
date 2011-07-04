module Spree
  module FlexiVariants
    # Singleton class to access the configuration object and it's preferences.
    #
    # Usage:
    #   Spree::FlexiVariants::Config[:foo]                  # Returns the foo preference
    #   Spree::FlexiVariants::Config[]                      # Returns a Hash with all the tax preferences
    #   Spree::FlexiVariants::Config.instance               # Returns the configuration object (SpreeFlexiVariantsConfiguration.first)
    #   Spree::FlexiVariants::Config.set(preferences_hash)  # Set the active shipping preferences as especified in +preference_hash+
    class Config
      include Singleton
      include PreferenceAccess
    
      class << self
        def instance
          return nil unless ActiveRecord::Base.connection.tables.include?('configurations')
          FlexiVariantsConfiguration.find_or_create_by_name("Default spree flexi variants configuration")
        end
      end
    end
  end
end
