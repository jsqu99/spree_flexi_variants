class OptionValuePricingDependency < ActiveRecord::Base
  belongs_to :dependent_option_pricing_configuration,:class_name => 'OptionPricingConfiguration::DependentOptionPricingConfiguration'

  belongs_to :dependent_option_value, :polymorphic => true
  belongs_to :independent_option_value, :polymorphic => true
end
