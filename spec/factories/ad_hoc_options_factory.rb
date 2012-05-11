Factory.define :ad_hoc_option_type, :class => Spree::AdHocOptionType do |f|
  f.association :product
  f.association :option_type
end

Factory.define :ad_hoc_option_value, :class => Spree::AdHocOptionType do |f|
  f.price_modifier 0
  f.association :option_value
  f.association :ad_hoc_option_type
end

