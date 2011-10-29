# used to assist us in pricing a variant
class OptionPricingConfiguration < ActiveRecord::Base
  # either option_type or product_option_type
  belongs_to :pricing_configurable, :polymorphic => true

  def compute(line_item,option_value)
    raise "this is an abstract class man, override!"
  end
end
