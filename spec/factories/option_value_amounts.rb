FactoryGirl.define do
  factory :option_value_amount do
    association :amount_option_pricing_configuration
    association :option_value
    amount { Forgery(:basic).number}
  end
end

