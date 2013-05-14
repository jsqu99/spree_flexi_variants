# I chose to create a new class instead of modifying the option_value class to include a price_modifier and fk back to ad_hoc_option_type
module Spree
  class AdHocOptionValue < ActiveRecord::Base
    belongs_to :ad_hoc_option_type
    belongs_to :option_value
    has_many :excluded_ad_hoc_option_values, :dependent => :destroy

    # currently no controller for normal users present
    attr_accessible :price_modifier, :ad_hoc_option_type_id, :option_value_id, :selected, :cost_price_modifier

    # this opens up a can of worms..deleting option values and having historical data still intact...ugh...what to do?...add 'deleted_at' somewhere along the chain?
    # has_many :ad_hoc_option_values_line_items, :dependent => :destroy

    # price_modifier
    alias :option_type :ad_hoc_option_type
    acts_as_list :scope => :ad_hoc_option_type
    default_scope order("position asc")

    delegate :name, :to => :option_value
    delegate :presentation, :to => :option_value

    def cost_price
      cost_price_modifier || price_modifier || 0
    end
  end
end
