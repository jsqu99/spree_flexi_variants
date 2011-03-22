Product.class_eval do
    has_many :product_option_values, :through => :product_option_types	# component of allowed configurations.  These are the pool of POSSIBLE option values
    has_many :configuration_exclusions  # component of allowed configurations.  Each exclusion represents a disallowed combination of product_option_values
    has_and_belongs_to_many :customization_types  # allowed customizations
end
