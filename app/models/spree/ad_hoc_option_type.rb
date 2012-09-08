module Spree
  class AdHocOptionType < ActiveRecord::Base
    belongs_to :option_type
    belongs_to :product
    belongs_to :price_affecting_option_type, :class_name => "Spree::AdHocOptionType"
    has_many :ad_hoc_option_values, :dependent => :destroy
    alias :option_values :ad_hoc_option_values

    accepts_nested_attributes_for :ad_hoc_option_values, :allow_destroy => true

    # currently no controller for normal users present 
    attr_accessible :is_required, :ad_hoc_option_values_attributes, :product_id, :option_type_id, :position

    default_scope order(:position)

    # price_modifier_type
    # is_required

    def price_depends_on_another_option?
      self.price_modifier_type.present? && self.price_modifier_type =~ /ercent/ && self.price_affecting_option_type.present?
    end

    def name
      option_type.name
    end

    def presentation
      option_type.presentation
    end
  end
end
