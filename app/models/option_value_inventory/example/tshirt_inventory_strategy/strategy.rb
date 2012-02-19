module OptionValueInventory
  module Example
    module TshirtInventoryStrategy
      class InventoryValue < ActiveRecord::Base
      set_table_name 'option_value_inventory_strategies'  # shared w/ parent.  this is probably some horrible indicator of a misuse of inheritance.  pondering this

        has_many :inventory_values, :class_name => 'OptionValueInventory::Example::TshirtInventoryStrategy::InventoryValue'

        def self.description
          "Use the size and color of a TShirt to compute the count_on_hand"
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
