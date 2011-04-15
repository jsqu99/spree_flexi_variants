class AdHocOptionType < ActiveRecord::Base
  belongs_to :option_type
  belongs_to :product
  has_many :ad_hoc_option_values
  alias :option_values :ad_hoc_option_values

  accepts_nested_attributes_for :ad_hoc_option_values, :allow_destroy => true

  # price_modifier_type
  # is_required
  def has_price_modifier?
    !(price_modifier_type.nil? || price_modifier_type.downcase=~/none/)
  end

  def presentation
    option_type.presentation
  end
end
