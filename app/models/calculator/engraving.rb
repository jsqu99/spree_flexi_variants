class Calculator::Engraving < Calculator
  preference :price_per_letter, :decimal

  def self.description
    "Engraving Calculator"
  end

  def self.register
    super
    ProductCustomizationType.register_calculator(self)
  end

  def compute(product_customization)
    return 0 unless valid_configuration? product_customization

    # expecting only one CustomizedProductOption
    value = product_customization.customized_product_options[0].value rescue ''
    value.length * self.preferred_price_per_letter
  end

  def valid_configuration?(product_customization)
    true
  end
end
