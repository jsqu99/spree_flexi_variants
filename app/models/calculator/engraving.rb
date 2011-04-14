class Calculator::Engraving < Calculator
  preference :price_per_letter, :decimal

  # TODO: this field shouldn't require a default value on the admin screen
  def required_fields
    {"inscription" => :string}
  end

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
    opt = product_customization.customized_product_options.detect {|cpo| cpo.customizable_product_option.name == "inscription" } rescue ''
    opt.value.length * preferred_price_per_letter
  end

  def valid_configuration?(product_customization)
    true
  end
end
