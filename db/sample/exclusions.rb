# uncomment out this entire file after creating a product with 3 ahot's
#p=Product.last
#ahov1=p.ad_hoc_variant_option_types[0].option_values[0]
#ahov2=p.ad_hoc_variant_option_types[1].option_values[0]
#ahov3=p.ad_hoc_variant_option_types[2].option_values[0]
#
#
#ave= AdHocVariantExclusion.new
#
#ave.product=p
#ave.save
#
#[ahov1,ahov2,ahov3].each do |ahov|
#  eov=ExcludedAdHocVariantOptionValue.new
#  eov.ad_hoc_variant_exclusion = ave
#  eov.ad_hoc_variant_option_value = ahov
#  eov.save
#end
#
