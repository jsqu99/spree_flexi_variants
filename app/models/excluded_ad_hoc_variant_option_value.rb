class ExcludedAdHocVariantOptionValue < ActiveRecord::Base
  belongs_to :ad_hoc_variant_exclusion
  belongs_to :ad_hoc_variant_option_value
end
