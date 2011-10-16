class OptionValueAmount < ActiveRecord::Base
  belongs_to :amount_option_pricing_configuration
  belongs_to :option_value
end
