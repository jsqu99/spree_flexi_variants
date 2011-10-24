# represents one of the following:

# option_value / amount
# product_option_value / amount

class OptionValueAmount < ActiveRecord::Base
  belongs_to :amount_option_pricing_configuration, :class_name => 'OptionPricingConfiguration::AmountOptionPricingConfiguration'
  belongs_to :option_value, :polymorphic => true
end
