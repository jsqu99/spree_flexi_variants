Factory.sequence(:product_sequence) {|n| "Product ##{n} - #{rand(9999)}"}

Factory.define :product do |f|
  f.name { Factory.next(:product_sequence) }
  f.description { Faker::Lorem.paragraphs(rand(5)+1).join("\n") }

  # associations:
#  f.tax_category {|r| TaxCategory.find(:first) || r.association(:tax_category)}
#  f.shipping_category {|r| ShippingCategory.find(:first) || r.association(:shipping_category)}

#  f.ad_hoc_option_types []

#  f.ad_hoc_variant_exclusions []

#  f.product_customization_types
#  f.product_customization_types {|pct| [pct.association(:product)]}

  f.price 19.99
  f.cost_price 17.00
  f.sku "ABC"
  f.available_on { 1.year.ago }
  f.deleted_at nil
end
