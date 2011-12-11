OptionType.class_eval do
  has_one :option_pricing_configuration, :as => :pricing_configurable, :dependent => :destroy

  #accepts_nested_attributes_for :option_pricing_configuration
  #attr_accessible :option_pricing_configuration

#  has_one :option_sku_configuration

  class_attribute :option_pricing_configurations
  self.option_pricing_configurations = Set.new
  def self.register_option_pricing_configuration(option_pricing_configuration)
    self.option_pricing_configurations.add(option_pricing_configuration)
  end
end
