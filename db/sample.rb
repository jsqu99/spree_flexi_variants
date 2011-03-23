# Create a 'Necklace" product
necklace = Product.create(:name => 'Necklace', :price => 0, :available_on => Time.now)

# A necklace can be one of many types of metals (e.g. gold, silver, etc.
metal_ot = OptionType.create(:name => 'metal', :presentation => 'Precious Metal')

gold_ov   = OptionValue.create(:option_type => metal_ot, :name => 'gold'  , :presentation => 'Gold')
silver_ov = OptionValue.create(:option_type => metal_ot, :name => 'silver', :presentation => 'Silver')


# Create two necklace variants
# Note that gold is more expensive than silver

gold_variant = Variant.create(:product=>necklace, :price =>  30)   # base price for the smallest possible Gold chain
gold_variant.option_values << gold_ov

silver_variant = Variant.create(:product=>necklace, :price =>  10) # base price for the smallest possible Silver chain
silver_variant.option_values << silver_ov



ct= CustomizationType.create(:name => "necklace_length", :presentation => "Size your necklace")
ct.products << necklace
length_calc    = Calculator::ProductLength.new(:preferred_multiplier => 2.35,
 	                                          :preferred_max_length => 100)
ct.calculator=length_calc
ct.customizable_product_options << CustomizableProductOption.create(:name => "necklace_length", :label => 'Length (cm)', :default_value => '10', :data_type => :decimal)


ct= CustomizationType.create(:name => "necklace_engraving", :presentation => "Say something romantic on the inside?")
ct.products << necklace
engraving_calc = Calculator::Engraving.new(:preferred_price_per_letter => 1.10)
ct.calculator = engraving_calc
ct.customizable_product_options << CustomizableProductOption.create(:name => "necklace_engraving", :label => 'Inscription', :data_type => :string)
