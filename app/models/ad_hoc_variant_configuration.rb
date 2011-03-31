class AdHocVariantConfiguration  < ActiveRecord::Base
  belongs_to :product

  # component of allowed configurations.  These are the pool of POSSIBLE option values
  has_many :ad_hoc_variant_option_types

  # component of allowed configurations.  Each exclusion represents a disallowed combination of ad_hoc_variant_option_values
  has_many :ad_hoc_variant_exclusions
  
end
