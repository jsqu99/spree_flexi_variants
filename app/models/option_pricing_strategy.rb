# used to assist us in pricing a variant
class OptionPricingStrategy < ActiveRecord::Base
  # either option_type or product_option_type
  belongs_to :strategy_option_type_reference, :polymorphic => true

  def all_combinations
    raise "this is an abstract class man, override!"
  end

  def compute(option_value, *other_option_values)
    raise "this is an abstract class man, override!"
  end

  def self.description
    "need a description for me"
  end

  def self.register
   OptionType.register_option_pricing_strategy(self)
  end
end
