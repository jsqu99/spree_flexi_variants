Factory.define :product_customization_type do |f|
  f.name  { Faker::Lorem.words }
  f.presentation  { Faker::Lorem.words }
  f.description  {  Faker::Lorem.words }
  f.products []
  f.association :calculator
end

Factory.define :customizable_product_option do |f|
  f.name  { Faker::Lorem.words }
  f.presentation  { Faker::Lorem.words }
  f.description  {  Faker::Lorem.words }
  f.data_validation { ({:type => :string, :required => false}).to_json }
  f.association :product_customization_type
end

Factory.define :product_customization do |f|
  f.association :product_customization_type
  f.association :line_item
end

Factory.define :customized_product_option do |f|
  f.value { Faker::Lorem.words }
  f.association :product_customization
  f.association :customizable_product_option
end

