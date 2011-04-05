require 'spree_core'
require 'spree_on_demand_variants_hooks'

module SpreeOnDemandVariants
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      Spree::Config.set :use_ajax_pricing_updates => true

      [Calculator::Engraving, Calculator::NumberOfObjectsTimesConstant, Calculator::ProductArea,Calculator::ProductLength].each(&:register)

    end

    config.to_prepare &method(:activate).to_proc
  end
end
