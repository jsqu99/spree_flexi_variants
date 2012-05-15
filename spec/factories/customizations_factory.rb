Factory.define :product_customization_type, :class => Spree::ProductCustomizationType do |f|
  f.name  { Faker::Lorem.words }
  f.presentation  { Faker::Lorem.words }
  f.description  {  Faker::Lorem.words }
end

Factory.define :customizable_product_option, :class => Spree::CustomizableProductOption do |f|
  f.name  { Faker::Lorem.words }
  f.presentation  { Faker::Lorem.words }
  f.description  {  Faker::Lorem.words }
  f.association :product_customization_type
end


Factory.define :product_customization, :class => Spree::ProductCustomization do |f|
  f.association :product_customization_type
  f.association :line_item
end

Factory.define :customized_product_option, :class => Spree::CustomizedProductOption do |f|
  f.value { Faker::Lorem.words }
  f.association :product_customization
  f.association :customizable_product_option
end


# now for the engraving customizations

Factory.define :customizable_inscription, :parent => :customizable_product_option do |f|
  f.name { "inscription" }
  f.presentation { "Inscription" }
  f.association :product_customization_type, :factory => :engraving_customization_type
end


Factory.define :customized_inscription, :parent => :customized_product_option do |f|
  f.value { "to my best friend" }
  f.association :product_customization # , :factory => :engraving_customization
  f.association :customizable_product_option, :factory => :customizable_inscription
end

Factory.define :engraving_calculator, :class => Spree::Calculator::Engraving do |f|
  f.after_create do |c|
    c.set_preference(:price_per_letter, 10.0)
  end
end

Factory.define :engraving_customization_type, :parent => :product_customization_type do |f|
  f.name "engraving"
  f.presentation "Engraving"
  f.after_create do |cust_type|
    cust_type.calculator = Factory(:engraving_calculator,:calculable =>  cust_type)
    Factory(:customizable_inscription, :product_customization_type => cust_type)
  end
end

Factory.define :engraving_customization, :parent => :product_customization do |f|
  f.association :product_customization_type, :factory => :engraving_customization_type
  f.customized_product_options { [ Factory(:customized_inscription) ]}
end

#Factory.define :product_with_engraving, :parent => :product do |f|
#  cust = Factory(:engraving_customization_type)
#  f.product_customization_types [cust]

#  f.after_create do |product|
#    cust.products << product
#  end
#end

