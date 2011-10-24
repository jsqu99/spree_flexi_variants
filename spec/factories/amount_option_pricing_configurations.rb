FactoryGirl.define do
  factory :amount_option_pricing_configuration, :class => OptionPricingConfiguration::AmountOptionPricingConfiguration do
    pricing_configurable { FactoryGirl.build(:option_type) }
    after_create { |c|
      FactoryGirl.create(:option_value_amount, :amount_option_pricing_configuration => c)
    }
  end
end
