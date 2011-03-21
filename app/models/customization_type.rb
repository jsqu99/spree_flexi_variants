class CustomizationType < ActiveRecord::Base
  calculated_adjustments

  has_and_belongs_to_many :customization_value_types, :join_table=>'customization_values_types_join'

end
