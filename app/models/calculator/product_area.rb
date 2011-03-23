class Calculator::ProductArea < Calculator
  preference :cost_per, :decimal

  preference :min_width, :integer, :default=>0
  preference :max_width, :integer

  preference :min_height, :integer, :default=>0
  preference :max_height, :integer

  preference :measurement_units, :string, :default => 'inches'
  preference :granularity, :string, :default => 'eighths'

  def self.description
    I18n.t("product_area_calculator")
  end

  def self.register
    super
    CustomizationType.register_calculator(self)
  end

  # as object we always get line items, as calculable we have Coupon, ShippingMethod
  def compute(product_customization)
    # TODO: what's the right way to differentiate inbound customized_product_options? e.g. which one is height, and which is width?

#    product_customization.value
    # self.preferred_discount_amount
    0
  end
end
