# used to assist us in pricing a variant, using an amount tied to a particular (dependent/independent) option value pair.
class OptionPricingConfiguration::DependentOptionPricingConfiguration  < OptionPricingConfiguration
  has_many :option_value_pricing_dependencies

#  def compute(dependent_option_value, variant) # the variant that is currently being formed
  def compute(dependent_option_value, *all_other_option_values)
    # implement strategy here
  end
end
