class CustomizableProductOption < ActiveRecord::Base
  # has these fields
  #      t.integer  :position,     :null => true
  #      t.string   :presentation,       :null => false
  #      t.string   :name,        :null => false
  #      t.string   :description, :null => true
  #      t.boolean  :is_required,    :default => false
  belongs_to :product_customization_type
end
