# used to assist us in pricing a variant, using an amount tied to a particular option value.
class OptionPricingConfiguration::AmountOptionPricingConfiguration < OptionPricingConfiguration
  # so for for now, we are working at the option_type level, not the product_option_type (coming soon), in which case
  # we'll prolly want to do something like product_option_value_amounts, maybe polymorphicly
  has_many :option_value_amounts


  # javascript will exist in a 'configuration-aware partial' to handle this hash
  def all_combinations
    # implement strategy here
    # {option_value_id: amount}
  end

  def compute(option_value, *other_option_values) # last arg is ignored by this configuration
    # find the pricing info for the option value
    obj = option_value_amounts.detect{|ova| ova.option_value_id == option_value.id}

    obj.amount || 0
  end
end
