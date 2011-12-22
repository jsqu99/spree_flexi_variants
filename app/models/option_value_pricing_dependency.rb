class OptionValuePricingDependency < ActiveRecord::Base
  belongs_to :dependent_option_pricing_strategy,:class_name => 'OptionPricingStrategy::DependentOptionPricingStrategy'

  belongs_to :dependent_option_value, :polymorphic => true
  belongs_to :independent_option_value, :polymorphic => true
end
