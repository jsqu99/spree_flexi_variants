FactoryGirl.define do
  factory :dependent_option_pricing_strategy do
    after_create { |c|
     c.option_value_pricing_dependencies<< FactoryGirl.create(:option_value_pricing_dependency)
    }
  end
end
