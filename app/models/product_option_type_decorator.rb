ProductOptionType.class_eval do
  has_one :option_pricing_strategy, :as => :strategy_option_type_reference, :dependent => :destroy
#  has_one :option_sku_strategy
end
