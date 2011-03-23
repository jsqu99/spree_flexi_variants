class Calculator::Engraving < Calculator
  preference :price_per_letter, :decimal

  def self.description
    I18n.t("engraving_calculator")
  end

  def self.register
    super
    CustomizationType.register_calculator(self)
  end

  def compute(customization)
    return 0 unless valid?

    # expecting only one CustomizedProductOption
    value = customization.customized_product_options[0].value rescue 0.0
    value * self.preferred_price_per_letter
  end

  def valid?(customization)
    true
  end
end
