class Customization < ActiveRecord::Base
  belongs_to :customization_type
  belongs_to :line_item
  has_many :customized_product_options 

  def price
    amount = customization_type.calculator.compute(self)
  end
end
