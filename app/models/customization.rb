class Customization < ActiveRecord::Base
  belongs_to :customization_type
  belongs_to :line_item
  has_many :customization_values  # # params[:customization] contains all the fields supplied by the customization_type_view

  def price
    amount = customization_type.calculator.compute(self)
  end
end
