class Calculator::ProductLength < Calculator
  preference :multiplier, :decimal

  preference :min_length, :integer, :default=>0
  preference :max_length, :integer
  preference :measurement_units, :string, :default => 'inches'
  preference :granularity, :string # , :default => 'eighths'

  def self.description
    I18n.t("product_length_calculator")
  end

  def self.register
    super
    CustomizationType.register_calculator(self)
  end

  def compute(customization)
    return 0 unless valid?

    # expecting only one CustomizedProductOption
    value = customization.customized_product_options[0].value rescue 0.0
    value * self.preferred_multiplier
  end

  def valid?(customization)
    true
  end
end
