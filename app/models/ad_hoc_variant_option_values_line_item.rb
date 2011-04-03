class AdHocVariantOptionValuesLineItem  < ActiveRecord::Base
  belongs_to :ad_hoc_variant_option_value
  belongs_to :line_item
end
