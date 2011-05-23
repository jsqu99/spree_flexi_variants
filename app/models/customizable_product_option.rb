class CustomizableProductOption < ActiveRecord::Base
  # has these fields
  #      t.integer  :position,     :null => true
  #      t.string   :presentation,       :null => false
  #      t.string   :name,        :null => false
  #      t.string   :description, :null => true
  #      t.string   :data_validation, :null => true

  belongs_to :product_customization_type

  # need this to access the associated preference from the calculator.  used primarily for the data validation restrictions e.g. numericality => gte, etc
  # has_one :calculator, :through => product_customization_type
  def calculator
    product_customization_type.calculator
  end
end
