class VariantSpecification < ActiveRecord::Base
  has_many :products
  has_many :option_values
  belongs_to :calculator
end
