OptionType.class_eval do
  has_one :option_pricing_configuration, :as => :pricing_configurable, :dependent => :destroy
#  has_one :option_sku_configuration
end
