class Calculator::ProductLength < Calculator
  preference :multiplier, :decimal

  preference :min_length, :integer, :default=>0
  preference :max_length, :integer
#  preference :measurement_units, :string, :default => 'inches'
#  preference :granularity, :string # , :default => 'eighths'

  def self.description
    "Product Length Calculator"
  end

  def self.register
    super
    ProductCustomizationType.register_calculator(self)
  end

  def compute(product_customization)

    return 0 unless valid_configuration? product_customization

    # expecting only one CustomizedProductOption
    value = product_customization.customized_product_options[0].value.to_f rescue 0.0
    value * self.preferred_multiplier
  end

  def valid_configuration?(product_customization)
    true
  end
end
