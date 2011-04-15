Product.class_eval do
  # These are the pool of POSSIBLE option values
  has_many :ad_hoc_option_types

  # Each exclusion represents a disallowed combination of ad_hoc_option_values
  has_many :ad_hoc_variant_exclusions

  # allowed customizations
  has_and_belongs_to_many :product_customization_types  
end
