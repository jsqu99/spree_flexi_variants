class CustomizableProductOption < ActiveRecord::Base
  belongs_to :customization_type
#  has_and_belongs_to_many :customization_types , :join_table=>'customization_values_types_join'
#  :label => 'Inches',
#  :position => 0,
#	  :name => :inches,
#	  :default_value => '0',
#	  :data_type => :whole_number_and_fraction,
#	  :required => true,
#	  :description'
#
end
