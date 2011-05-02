Factory.define(:line_item2, :class=>LineItem) do |record|
  record.quantity 1
  record.price { BigDecimal.new("10.00") }

  # associations:
  record.association(:order, :factory => :order)
  record.association(:variant, :factory => :variant)
end

Factory.define(:line_item_with_ad_hoc_options, :parent => :line_item2) do |li|
#  li.ad_hoc_option_values_line_items {|ahovli| [ahovli.association(:ad_hoc_option_values_line_item), ahovli.association(:ad_hoc_option_values_line_item, :factory=>)]}
  li.ad_hoc_option_values_line_items {[Factory(:ahov_line_item, :ad_hoc_option_value => Factory(:ahov1), :line_item => li), Factory(:ahov_line_item, :ad_hoc_option_value => Factory(:ahov2), :line_item => li)]}
end

Factory.define(:ahov_line_item) do |f|
  f.association(:ad_hoc_option_value)
  f.association(:line_item)
end

#Factory.define(:line_item_with_customizations, parent => :line_item) do |li|
#  li.product_customizations {[]|
#end
