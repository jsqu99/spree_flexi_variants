FactoryGirl.define do
  factory :no_charge_calculator, :class => Spree::Calculator::NoCharge do
  end
end

FactoryGirl.define do
  factory :product_customization_type, :class => Spree::ProductCustomizationType do
    sequence(:name) { |n| "Product Customization Type ##{n} - #{Kernel.rand(9999)}" }
    sequence(:presentation) { |n| "Product Customization Type Presentation ##{n} - #{Kernel.rand(9999)}" }

    calculator { |p| p.association(:no_charge_calculator) }
  end
end

FactoryGirl.define do
  factory :product_customization, :class => Spree::ProductCustomization do
    product_customization_type { |p| p.association(:product_customization_type) }
    line_item { |p| p.association(:line_item) }
  end
end

FactoryGirl.define do
  factory :customizable_product_option, :class => Spree::CustomizableProductOption do
    sequence(:name) { |n| "Customizable Product Option ##{n} - #{Kernel.rand(9999)}" }
    sequence(:presentation) { |n| "Customizable Product Option Presentation ##{n} - #{Kernel.rand(9999)}" }
    sequence(:description) { |n| "Customizable Product Option Description ##{n} - #{Kernel.rand(9999)}" }

    product_customization_type { |p| p.association(:product_customization_type) }
    
  end
end

FactoryGirl.define do
  factory :customized_product_option, :class => Spree::CustomizedProductOption do
    product_customization { |p| p.association(:product_customization) }
    customizable_product_option { |p| p.association(:customizable_product_option) }
    sequence(:value) { |n| "Customizaed Product Option Value ##{n} - #{Kernel.rand(9999)}" }
  end
end

FactoryGirl.define do
  factory :ad_hoc_option_type, :class => Spree::AdHocOptionType do
    product { |p| p.association(:product) }
    option_type { |p| p.association(:option_type) }
  end
end


FactoryGirl.define do
  factory :ad_hoc_option_value, :class => Spree::AdHocOptionValue do
    ad_hoc_option_type { |p| p.association(:ad_hoc_option_type) }
    option_value { |p| p.association(:option_value) }
  end
end

FactoryGirl.define do
  factory :customizable_product, :parent => :base_product do
    after(:create) do |p|
      p.product_customization_types << FactoryGirl.create(:product_customization_type)
    end
  end
end

FactoryGirl.define do
  factory :ad_hoc_variant_exclusion, :class => Spree::AdHocVariantExclusion do
    product { |p| p.association(:product) }
  end
end

FactoryGirl.define do
  factory :excluded_ad_hoc_option_value, :class => Spree::ExcludedAdHocOptionValue do
    ad_hoc_variant_exclusion { |p| p.association(:ad_hoc_variant_exclusion) }
    ad_hoc_option_value { |p| p.association(:ad_hoc_option_value) }
  end
end

