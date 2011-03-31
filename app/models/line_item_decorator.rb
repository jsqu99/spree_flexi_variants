LineItem.class_eval do
  has_and_belongs_to_many :ad_hoc_variant_option_values
  has_many :product_customizations 
end
