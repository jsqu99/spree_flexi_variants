module OptionValueSku
  module Example
    module TshirtSkuStrategy
    # used to assist us in determining a sku for a variant, using a sku component tied to a particular option value.
    class Strategy < OptionValueSku::Strategy
      set_table_name 'option_value_sku_strategies'  # shared w/ parent.  this is probably some horrible indicator of a misuse of inheritance.  pondering this

      # so for for now, we are working at the option_type level, not the product_option_type (coming soon), in which case
      # we'll prolly want to do something like product_option_value_sku_components, maybe polymorphicly
      has_many :sku_components, :class_name => 'OptionValueSku::Example::TshirtSkuStrategy::SkuComponent'

      def self.description
        "Use the size and color of a TShirt to compute a SKU"
      end

      def compute(option_values)
        # find the pricing info for the option value
        #    obj = option_value_amounts.detect{|ova| ova.option_value_id == option_value.id}
        #    obj.amount || 0
      end
    end
  end
end
end
