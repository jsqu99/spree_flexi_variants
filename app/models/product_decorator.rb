Product.class_eval do
  has_many :product_option_values, :dependent => :destroy
  has_many :option_values, :through => :product_option_values #  why doesn't this work?

  def has_on_demand_variants?
    has_on_demand_variants
  end
end
