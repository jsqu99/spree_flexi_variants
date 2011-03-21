class ConfigurationExclusion < ActiveRecord::Base
  belongs_to :product
  has_many :excluded_product_option_values
 end
