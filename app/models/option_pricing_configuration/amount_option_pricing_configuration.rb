# One amount per option value.
class OptionPricingConfiguration::AmountOptionPricingConfiguration < OptionPricingConfiguration
  # so for for now, we are working at the option_type level, not the product_option_type (coming soon), in which case
  # we'll prolly want to do something like product_option_value_amounts, maybe polymorphicly
  has_many :option_value_amounts

  def compute(line_item,option_value)
    # find the pricing info for the option value
    obj = option_value_amounts.detect{|ova| ova.option_value_id == option_value.id}

    obj.amount || 0
  end
end
