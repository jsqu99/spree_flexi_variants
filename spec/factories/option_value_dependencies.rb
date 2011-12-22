FactoryGirl.define do
  factory :option_value_dependency do
    dependent_option_pricing_strategy
    after_build {|c|
      c.dependent_option_value = FactoryGirl.create(:option_value)
      c.independent_option_value = FactoryGirl.create(:option_value)
    }
    amount { Forgery(:basic).number}
  end
end

