class ProductOptionTypeOptionValue < ActiveRecord::Base
  belongs_to :product_option_type
  belongs_to :option_value
#  acts_as_list :scope => :product_option_type
end
