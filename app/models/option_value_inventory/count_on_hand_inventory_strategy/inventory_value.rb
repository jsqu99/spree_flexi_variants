module OptionValueInventory
  module CountOnHandInventoryStrategy
    class InventoryValue < ActiveRecord::Base
      set_table_name 'count_on_hand_inventory_values'

      belongs_to :strategy,:class_name => 'OptionValueInventory::CountOnHandInventoryStrategy::Strategy'

      belongs_to :dependent_option_value, :polymorphic => true
      belongs_to :independent_option_value, :polymorphic => true
    end
  end
end
