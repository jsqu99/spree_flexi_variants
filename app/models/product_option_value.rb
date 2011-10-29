# When option values are customized on a per-product basis, this
# class serves as a mapping
class ProductOptionValue < ActiveRecord::Base
  belongs_to :product
  belongs_to :option_value

  delegate :presentation, :to => :option_value

  # can be subclassed.
  #    :product_id
  #    :type
  #    :option_value_id
end
