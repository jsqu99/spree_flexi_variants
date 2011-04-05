# I chose to create a new class instead of modifying the option_value class to include a price_modifier and fk back to ad_hoc_variant_option_type
class AdHocVariantOptionValue < ActiveRecord::Base
  belongs_to :ad_hoc_variant_option_type
  belongs_to :option_value
  # price_modifier
  alias :option_type :ad_hoc_variant_option_type
end
