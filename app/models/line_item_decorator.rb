LineItem.class_eval do
  has_and_belongs_to_many :product_option_values
  has_many :customizations 
end
