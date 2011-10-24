class OptionPricingConfiguration::DependentOptionPricingConfiguration  < OptionPricingConfiguration
  has_many :option_value_pricing_dependencies

  def compute(line_item, option_value)
    # implement strategy here
  end
end
