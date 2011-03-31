# Create a 'Necklace" product
necklace = Product.create(:name => 'Necklace', :price => 5, :available_on => Time.now)

# A necklace can be one of many types of metals (e.g. gold, silver, etc.)
metal_ot = OptionType.create(:name => 'metal', :presentation => 'Precious Metal')

gold_ov   = OptionValue.create(:option_type => metal_ot, :name => 'gold'  , :presentation => 'Gold')
silver_ov = OptionValue.create(:option_type => metal_ot, :name => 'silver', :presentation => 'Silver')


# Create two necklace variants
# Note that gold is more expensive than silver

gold_variant = Variant.create(:product=>necklace, :price =>  30)   # base price for the smallest possible Gold chain
gold_variant.option_values << gold_ov

silver_variant = Variant.create(:product=>necklace, :price =>  10) # base price for the smallest possible Silver chain
silver_variant.option_values << silver_ov



ct= ProductCustomizationType.create(:name => "necklace_length", :presentation => "Size your necklace")
ct.products << necklace
length_calc    = Calculator::ProductLength.new(:preferred_multiplier => 3.0,
 	                                          :preferred_max_length => 100)
ct.calculator=length_calc
ct.customizable_product_options << CustomizableProductOption.create(:name => "necklace_length", :presentation => 'Length (cm)', :default_value => '10')


ct= ProductCustomizationType.create(:name => "necklace_engraving", :presentation => "Say something romantic on the inside?")
ct.products << necklace
engraving_calc = Calculator::Engraving.new(:preferred_price_per_letter => 2.0)
ct.calculator = engraving_calc
ct.customizable_product_options << CustomizableProductOption.create(:name => "necklace_engraving", :presentation => 'Inscription')


# Now for the 'product_option_values'
bogus1_ot = OptionType.create(:name => 'bogus1', :presentation => 'Bogus1')

bogus1_ov1   = OptionValue.create(:option_type => bogus1_ot, :name => 'bogus1_ov1'  , :presentation => 'Bogus Option1')
bogus1_ov2   = OptionValue.create(:option_type => bogus1_ot, :name => 'bogus1_ov2', :presentation => 'Bogus Option2')

bogus2_ot = OptionType.create(:name => 'bogus2', :presentation => 'Bogus2')

bogus2_ov1   = OptionValue.create(:option_type => bogus2_ot, :name => 'bogus2_ov1'  , :presentation => 'Another Bogus Option1')
bogus2_ov2   = OptionValue.create(:option_type => bogus2_ot, :name => 'bogus2_ov2', :presentation => 'Another Bogus Option2')


pot1=AdHocVariantOptionType.create(:product_id => necklace.id, :option_type => bogus1_ot, :price_modifier_type => 'single') # TODO revist the relevance/naming of this field
pot2=AdHocVariantOptionType.create(:product_id => necklace.id, :option_type => bogus2_ot, :price_modifier_type => 'single') 


AdHocVariantOptionValue.create(:price_modifier => '1.11', :option_value => bogus1_ov1, :ad_hoc_variant_option_type=>pot1)
AdHocVariantOptionValue.create(:price_modifier => '2.22', :option_value => bogus1_ov2, :ad_hoc_variant_option_type=>pot1)
AdHocVariantOptionValue.create(:price_modifier => '3.33', :option_value => bogus2_ov1, :ad_hoc_variant_option_type=>pot2)
AdHocVariantOptionValue.create(:price_modifier => '4.44', :option_value => bogus2_ov2, :ad_hoc_variant_option_type=>pot2)

