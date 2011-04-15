# I chose to create a new class instead of modifying the option_value class to include a price_modifier and fk back to ad_hoc_option_type
class AdHocOptionValue < ActiveRecord::Base
  belongs_to :ad_hoc_option_type
  belongs_to :option_value
  # price_modifier
  alias :option_type :ad_hoc_option_type

  def presentation
    option_value.presentation
  end
end
