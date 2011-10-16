# One amount per option value.
class AmountOptionPricingConfiguration < ActiveRecord::Base
  belongs_to :pricing_configurable, :polymorphic => true
  has_many :option_value_amounts

  def compute(line_item,option_value)
    # find the pricing info for the option value
    obj = option_value_amounts.detect{|ova| ova.option_value_id == option_value.id)

    obj.amount || 0
  end
end
