class Calculator::AmountTimesConstant < Calculator
  preference :multiplier, :decimal

  preference :min_amount, :integer, :default=>0
  preference :max_amount, :integer

  def required_fields
    {"amount" => :decimal}
  end

  def self.description
    "Amount Times Constant Calculator"
  end

  def self.register
    super
    ProductCustomizationType.register_calculator(self)
  end

  def compute(product_customization)

    return 0 unless valid_configuration? product_customization

    # expecting only one CustomizedProductOption
    value = product_customization.customized_product_options[0].value.to_f rescue 0.0
    value.to_i * self.preferred_multiplier
  end

  def valid_configuration?(product_customization)
    true
  end
end
