FactoryGirl.define do
  factory :amount_option_pricing_strategy, :class => OptionPricingStrategy::AmountOptionPricingStrategy do
    strategy_option_type_reference { FactoryGirl.build(:option_type) }
    after_create { |c|
      FactoryGirl.create(:option_value_amount, :amount_option_pricing_strategy => c)
    }
  end
end
