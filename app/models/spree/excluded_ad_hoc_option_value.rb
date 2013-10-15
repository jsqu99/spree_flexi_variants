module Spree
  class ExcludedAdHocOptionValue < ActiveRecord::Base
    belongs_to :ad_hoc_variant_exclusion
    belongs_to :ad_hoc_option_value
    
    #attr_accessible :ad_hoc_variant_exclusion, :ad_hoc_option_value_id
  end
end
