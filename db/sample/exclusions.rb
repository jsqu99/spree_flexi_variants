# uncomment out this entire file after creating a product with 3 ahot's
product = Product.create(:name => 'ExclusionExample', :price => 5, :available_on => Time.now)

ot1 = OptionType.create(:name => 'ot1', :presentation => 'OptType1')
ot2 = OptionType.create(:name => 'ot2', :presentation => 'OptType2')
ot3 = OptionType.create(:name => 'ot3', :presentation => 'OptType3')

ov_1_1 = OptionValue.create(:option_type => ot1, :name => 'ov_1_1'  , :presentation => 'OV_1_1')
ov_1_2 = OptionValue.create(:option_type => ot1, :name => 'ov_1_2', :presentation => 'OV_1_2')

ov_2_1 = OptionValue.create(:option_type => ot2, :name => 'ov_2_1'  , :presentation => 'OV_2_1')
ov_2_2 = OptionValue.create(:option_type => ot2, :name => 'ov_2_2', :presentation => 'OV_2_2')

ov_3_1 = OptionValue.create(:option_type => ot3, :name => 'ov_3_1'  , :presentation => 'OV_3_1')
ov_3_2 = OptionValue.create(:option_type => ot3, :name => 'ov_3_2', :presentation => 'OV_3_2')


ahot1=AdHocOptionType.create(:product => product, :option_type => ot1)
ahot2=AdHocOptionType.create(:product => product, :option_type => ot2)
ahot3=AdHocOptionType.create(:product => product, :option_type => ot3)

ahov_1_1=AdHocOptionValue.create(:ad_hoc_option_type => ahot1, :option_value => ov_1_1, :price_modifier => 1)
ahov_1_2=AdHocOptionValue.create(:ad_hoc_option_type => ahot1, :option_value => ov_1_2, :price_modifier => 2)

ahov_2_1=AdHocOptionValue.create(:ad_hoc_option_type => ahot2, :option_value => ov_2_1, :price_modifier => 3)
ahov_2_2=AdHocOptionValue.create(:ad_hoc_option_type => ahot2, :option_value => ov_2_2, :price_modifier => 4)

ahov_3_1=AdHocOptionValue.create(:ad_hoc_option_type => ahot3, :option_value => ov_3_1, :price_modifier => 0)
ahov_3_2=AdHocOptionValue.create(:ad_hoc_option_type => ahot3, :option_value => ov_3_2, :price_modifier => 5)


ave= AdHocVariantExclusion.new
ave.product=product
ave.save
[ahov_1_1,ahov_2_1,ahov_3_1].each do |ahov|
  eov=ExcludedAdHocOptionValue.new
  eov.ad_hoc_variant_exclusion = ave
  eov.ad_hoc_option_value = ahov
  eov.save
end

ave= AdHocVariantExclusion.new
ave.product=product
ave.save
[ahov_2_1,ahov_3_1].each do |ahov|
  eov=ExcludedAdHocOptionValue.new
  eov.ad_hoc_variant_exclusion = ave
  eov.ad_hoc_option_value = ahov
  eov.save
end

ave= AdHocVariantExclusion.new
ave.product=product
ave.save
[ahov_1_2,ahov_3_2].each do |ahov|
  eov=ExcludedAdHocOptionValue.new
  eov.ad_hoc_variant_exclusion = ave
  eov.ad_hoc_option_value = ahov
  eov.save
end

