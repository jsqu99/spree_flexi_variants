FactoryGirl.define do
  factory :amount_option_pricing_strategy, :class => OptionPricingStrategy::AmountOptionPricingStrategy do
    pricing_strategy { FactoryGirl.build(:option_type) }
    after_create { |c|
      FactoryGirl.create(:option_value_amount, :amount_option_pricing_strategy => c)
    }
  end
end
