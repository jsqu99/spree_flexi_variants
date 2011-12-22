FactoryGirl.define do
  factory :option_value_amount do
    amount_option_pricing_strategy
    after_build {|c|
      c.option_value = FactoryGirl.create(:option_value)
    }
    amount { Forgery(:basic).number}
  end
end

