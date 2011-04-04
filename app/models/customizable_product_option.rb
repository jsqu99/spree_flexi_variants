class CustomizableProductOption < ActiveRecord::Base
  # has these fields
  #      t.integer  :position,     :null => true
  #      t.string   :presentation,       :null => false
  #      t.string   :name,        :null => false
  #      t.string   :description, :null => true
  #      t.boolean  :is_required,    :default => false
  #      t.string   :default_value

  belongs_to :product_customization_type
end



#  :presentation => 'Inches',
#  :position => 0,
#	  :name => :inches,
#	  :default_value => '0',
#	  :is_required => true,
#	  :description'
#
