module OptionValueInventory
  module DependentInventoryStrategy

    class InventoryValue < ActiveRecord::Base
      set_table_name 'dependent_inventory_values'

      belongs_to :strategy,:class_name => 'OptionValueInventory::DependentInventoryStrategy::Strategy'

      belongs_to :dependent_option_value, :polymorphic => true
      belongs_to :independent_option_value, :polymorphic => true
    end
  end
end
