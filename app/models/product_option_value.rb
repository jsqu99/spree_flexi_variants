class ProductOptionValue < ActiveRecord::Base
  belongs_to :product_option_type
  belongs_to :option_value
end
