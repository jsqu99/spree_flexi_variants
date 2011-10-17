require 'spree_core'

module SpreeFlexiVariants
  class Engine < Rails::Engine
    engine_name 'spree_flexi_variants'

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
      Dir.glob(File.join(File.dirname(__FILE__), "../app/overrides/**/*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
      initializer "spree.register.calculators" do |app|
        app.config.spree.calculators.product_customization_types = [
          Calculator::Engraving,
          Calculator::AmountTimesConstant,
          Calculator::ProductArea,
          Calculator::CustomizationImage
        ]
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
