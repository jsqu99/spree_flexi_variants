module Spree
  class AdHocOptionValuesLineItem  < ActiveRecord::Base
    belongs_to :ad_hoc_option_value
    belongs_to :line_item
  end
end
