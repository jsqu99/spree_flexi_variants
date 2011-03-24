class Calculator::Engraving < Calculator
  preference :price_per_letter, :decimal

  def self.description
    "Engraving Calculator"
  end

  def self.register
    super
    CustomizationType.register_calculator(self)
  end

  def compute(customization)
    return 0 unless valid? customization

    # expecting only one CustomizedProductOption
    value = customization.customized_product_options[0].value rescue ''
    value.length * self.preferred_price_per_letter
  end

  def valid?(customization)
    true
  end
end
