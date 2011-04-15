require 'spree_core'
require 'spree_flexi_variants_hooks'

module SpreeFlexiVariants
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

#      Spree::Config.set :use_ajax_pricing_updates => true

      [Calculator::Engraving, Calculator::AmountTimesConstant, Calculator::ProductArea].each(&:register)

      # overwrite the spree helper to include our extension fields
#      Spree::BaseHelper.module_eval do
#        def variant_options(v, allow_back_orders = Spree::Config[:allow_backorders], include_style = true)
#          list = "this the the new method!"
#          #list = v.options_text
#          #list = include_style ? "<span class =\"out-of-stock\">(" + t("out_of_stock") + ") #{list}</span>" : "#{t("out_of_stock")} #{list}" unless (allow_back_orders || v.in_stock?)
#          list
#        end
#      end
#
    end

    config.to_prepare &method(:activate).to_proc
  end
end
