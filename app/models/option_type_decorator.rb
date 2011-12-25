OptionType.class_eval do
  has_one :option_pricing_strategy, :as => :option_type_reference, :dependent => :destroy

  #accepts_nested_attributes_for :option_pricing_strategy
  #attr_accessible :option_pricing_strategy

  # has_one :option_sku_strategy
  class_attribute :option_pricing_strategies
  class_attribute :sku_strategies
  class_attribute :inventory_strategies

  self.option_pricing_strategies = Set.new
  self.sku_strategies = Set.new
  self.inventory_strategies = Set.new

  def self.register_option_pricing_strategy(option_pricing_strategy)
    self.option_pricing_strategies.add(option_pricing_strategy)
  end
  def self.register_sku_strategy(sku_strategy)
    self.sku_strategies.add(sku_strategy)
  end
  def self.register_inventory_strategy(inventory_strategy)
    self.inventory_strategies.add(inventory_strategy)
  end
end
