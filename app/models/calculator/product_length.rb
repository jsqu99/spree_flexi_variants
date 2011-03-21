class Calculator::ProductLength < Calculator
  preference :cost_per, :decimal

  preference :min_length, :integer, :default=>0
  preference :max_length, :integer
  preference :measurement_units, :string, :default => 'inches'
  preference :granularity, :string, :default => 'eighths'

  def self.description
    I18n.t("product_length_calculator")
  end

  def self.register
    super
    ProductCustomizationType.register_calculator(self)
  end

  # as object we always get line items, as calculable we have Coupon, ShippingMethod
  def compute(product_customization)

    product_customization.value
      # self.preferred_discount_amount
    
  end
end
