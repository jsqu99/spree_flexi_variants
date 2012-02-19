module OptionValueSku
  # used to assist us in determining a sku for a variant
  class Strategy < ActiveRecord::Base

    set_table_name 'option_value_sku_strategies'

    # either option_type or product_option_type
    belongs_to :option_type_reference, :polymorphic => true

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
      OptionType.register_sku_strategy(self)
    end
  end
end
