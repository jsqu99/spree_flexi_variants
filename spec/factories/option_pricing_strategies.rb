# intentionally not supplying an amounts
FactoryGirl.define do
  factory :option_pricing_strategy, :class => OptionValuePricing::AmountStrategy::Strategy do
    option_type_reference { FactoryGirl.build(:option_type) }
  end
end
