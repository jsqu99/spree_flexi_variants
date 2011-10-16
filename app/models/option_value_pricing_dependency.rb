class OptionValuePricingDependency < ActiveRecord::Base
  belongs_to :dependent_option_pricing_configuration
  belongs_to :option_value, :as => :dependent_option_value
  belongs_to :option_value, :as => :independent_option_value
end
