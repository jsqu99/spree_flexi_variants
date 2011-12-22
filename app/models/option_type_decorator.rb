OptionType.class_eval do
  has_one :option_pricing_strategy, :as => :pricing_strategy, :dependent => :destroy

  #accepts_nested_attributes_for :option_pricing_strategy
  #attr_accessible :option_pricing_strategy

  # has_one :option_sku_strategy

  class_attribute :option_pricing_strategies
  self.option_pricing_strategies = Set.new
  def self.register_option_pricing_strategy(option_pricing_strategy)
    self.option_pricing_strategies.add(option_pricing_strategy)
  end
end
