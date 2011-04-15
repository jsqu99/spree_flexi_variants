LineItem.class_eval do
  has_many :ad_hoc_option_values_line_items
  has_many :ad_hoc_option_values, :through => :ad_hoc_option_values_line_items
  has_many :product_customizations 
end
