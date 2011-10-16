class DependentOptionPricingConfiguration  < ActiveRecord::Base
  belongs_to :pricing_configurable, :polymorphic => true
  has_many :option_values_dependencies

  def compute(line_item, option_value)
    # implement strategy here
  end
end
