class OptionValueInventoryDependency < ActiveRecord::Base
  belongs_to :dependent_inventory_strategy,:class_name => 'OptionInventoryStrategy::DependentInventoryStrategy'

  belongs_to :dependent_option_value, :polymorphic => true
  belongs_to :independent_option_value, :polymorphic => true
end
