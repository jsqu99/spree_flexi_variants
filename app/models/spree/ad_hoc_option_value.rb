# I chose to create a new class instead of modifying the option_value class to include a price_modifier and fk back to ad_hoc_option_type
module Spree
  class AdHocOptionValue < ActiveRecord::Base
    belongs_to :ad_hoc_option_type
    belongs_to :option_value
    has_many :excluded_ad_hoc_option_values, :dependent => :destroy

    # this opens up a can of worms..deleting option values and having historical data still intact...ugh...what to do?...add 'deleted_at' somewhere along the chain?
    # has_many :ad_hoc_option_values_line_items, :dependent => :destroy

    # price_modifier
    alias :option_type :ad_hoc_option_type
    acts_as_list :scope => :ad_hoc_option_type
    default_scope order("position asc")

    def presentation
      option_value.presentation
    end

    def price(selected_option_values = nil)
      if self.ad_hoc_option_type.price_depends_on_another_option?
        return nil unless selected_option_values.present?    # price is undefined 
        
        # find the driving option value
        driving_option_value = 
          selected_option_values.detect do |option_value| 
            option_value.ad_hoc_option_type == self.ad_hoc_option_type.price_affecting_option_type 
          end

        return nil unless driving_option_value.present?    # price is undefined if the driving option value wasn't passed in
        return driving_option_value.price * self.price_modifier / 100
      else
        return self.price_modifier || 0
      end
    end
  end
end
