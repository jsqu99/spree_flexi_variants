ProductOptionType.class_eval do
  has_one :option_pricing_strategy, :as => :pricing_strategy, :dependent => :destroy
#  has_one :option_sku_strategy
end
