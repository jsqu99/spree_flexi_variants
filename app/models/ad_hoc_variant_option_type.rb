class AdHocVariantOptionType < ActiveRecord::Base
  belongs_to :option_type
  belongs_to :product
  has_many :option_values, :class_name => "AdHocVariantOptionValue"

  accepts_nested_attributes_for :option_values, :allow_destroy => true

  # price_modifier_type
  # is_required
  def has_price_modifier?
    !(price_modifier_type.nil? || price_modifier_type.downcase=~/none/)
  end
end
