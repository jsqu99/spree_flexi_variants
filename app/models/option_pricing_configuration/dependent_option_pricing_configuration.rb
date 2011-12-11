# used to assist us in pricing a variant, using an amount tied to a particular (dependent/independent) option value pair.
class OptionPricingConfiguration::DependentOptionPricingConfiguration  < OptionPricingConfiguration
  has_many :option_value_pricing_dependencies

  def self.description
    "Price is dependent on other option value(s)"
  end

  # javascript will exist in a 'configuration-aware partial' to handle this hash
  def all_combinations
    # implement strategy here
    # {option_value_id: {other_option_value_id : amount}}
  end

  def compute(option_value, *other_option_values)
    # implement strategy here
  end
end
