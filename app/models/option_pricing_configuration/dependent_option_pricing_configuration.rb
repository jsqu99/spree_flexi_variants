# used to assist us in pricing a variant, using an amount tied to a particular (dependent/independent) option value pair.
class OptionPricingConfiguration::DependentOptionPricingConfiguration  < OptionPricingConfiguration
  has_many :option_value_pricing_dependencies

  def compute(line_item, option_value)
    # implement strategy here
  end
end
