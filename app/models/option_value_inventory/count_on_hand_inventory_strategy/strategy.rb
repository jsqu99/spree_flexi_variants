module OptionValueInventory
  module CountOnHandInventoryStrategy
    class Strategy < OptionValueInventory::Strategy
      set_table_name 'option_value_inventory_strategies'  # shared w/ parent.  this is probably some horrible indicator of a misuse of inheritance.  pondering this

      has_many :inventory_values, :class_name => OptionValueInventory::CountOnHandInventoryStrategy::InventoryValue

      def self.description
        "Inventory is dependent on other option value(s)"
      end

      def compute(option_value, *other_option_values)
        # implement strategy here
      end
    end
  end
end
