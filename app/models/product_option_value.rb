class ProductOptionValue < ActiveRecord::Base
  belongs_to :product
  belongs_to :option_value
  acts_as_list :scope => :product
end
