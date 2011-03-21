class ExcludedProductOptionValue < ActiveRecord::Base
  belongs_to :configuration_exclusion
  belongs_to :product_option_value
end
