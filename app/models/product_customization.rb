class ProductCustomization < ActiveRecord::Base
  belongs_to :product_customization_type
  belongs_to :line_item
  has_many :customized_product_options 

  def price
    amount = product_customization_type.calculator.compute(self)
  end
end
