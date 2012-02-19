module OptionValueInventory
  # used to assist us in keeping track of inventory for a variant
  class Strategy < ActiveRecord::Base
    # this type of strategy is only relevant at the product_option_type level
    # (not the option_type level as well like the sku & pricing strategies)
    set_table_name 'option_value_inventory_strategies'

    belongs_to :product_option_type

    def self.description
      "need a description for me"
    end

    def self.register
      OptionType.register_inventory_strategy(self)
    end
  end
end
