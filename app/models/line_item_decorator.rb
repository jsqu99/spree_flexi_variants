LineItem.class_eval do
  has_many :product_option_values
  has_many :customizations 
end
