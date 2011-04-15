# Create a 'Cake" product
cake = Product.create(:name => 'Cake', :price => 5, :available_on => Time.now)

cake_size_ot = OptionType.create(:name => 'cake_size', :presentation => 'Size')

small_ov   = OptionValue.create(:option_type => cake_size_ot, :name => 'small'  , :presentation => 'Small')
medium_ov = OptionValue.create(:option_type => cake_size_ot, :name => 'medium', :presentation => 'Medium')
large_ov = OptionValue.create(:option_type => cake_size_ot, :name => 'large', :presentation => 'Large')


# Create three cake variants

small_variant = Variant.create(:product=>cake, :price =>  5)  
small_variant.option_values << small_ov

medium_variant = Variant.create(:product=>cake, :price =>  10)
medium_variant.option_values << medium_ov

large_variant = Variant.create(:product=>cake, :price =>  20)
large_variant.option_values << large_ov



ct= ProductCustomizationType.create(:name => "cake_candles", :presentation => "Add candles?")
ct.products << cake
length_calc    = Calculator::AmountTimesConstant.new(:preferred_multiplier => 0.10)  # ten cents per candle
ct.calculator=length_calc
ct.customizable_product_options << CustomizableProductOption.create(:name => "amount", :presentation => 'How Many Candles?', :data_type => "integer")


ct= ProductCustomizationType.create(:name => "cake_quote", :presentation => "Write something on the cake?")
ct.products << cake
engraving_calc = Calculator::Engraving.new(:preferred_price_per_letter => 0.5)
ct.calculator = engraving_calc
ct.customizable_product_options << CustomizableProductOption.create(:name => "inscription", :presentation => 'Write your message here')


# Now for the 'product_option_values'
sprinkles_ot = OptionType.create(:name => 'sprinkles', :presentation => 'Sprinkles')

chocolate_ov   = OptionValue.create(:option_type => sprinkles_ot, :name => 'chocolate'  , :presentation => 'Chocolate')
rainbow_ov   = OptionValue.create(:option_type => sprinkles_ot, :name => 'rainbow', :presentation => 'Rainbow')

icing_ot = OptionType.create(:name => 'icing', :presentation => 'Icing')

chocolate_icing_ov   = OptionValue.create(:option_type => icing_ot, :name => 'chocolate'  , :presentation => 'Chocolate')
vanilla_icing_ov     = OptionValue.create(:option_type => icing_ot, :name => 'vanilla', :presentation => 'Vanilla')
strawberry_icing_ov  = OptionValue.create(:option_type => icing_ot, :name => 'strawberry', :presentation => 'Strawberry')


sprinkles_pot=AdHocOptionType.create(:product_id => cake.id, :option_type => sprinkles_ot, :price_modifier_type => 'single') # TODO revist the relevance/naming of this field
icing_pot=AdHocOptionType.create(:product_id => cake.id, :option_type => icing_ot, :price_modifier_type => 'single') 


AdHocOptionValue.create(:price_modifier => '1.11', :option_value => chocolate_ov, :ad_hoc_option_type=>sprinkles_pot)
AdHocOptionValue.create(:price_modifier => '2.22', :option_value => rainbow_ov, :ad_hoc_option_type=>sprinkles_pot)
AdHocOptionValue.create(:price_modifier => '3.33', :option_value => chocolate_icing_ov, :ad_hoc_option_type=>icing_pot)
AdHocOptionValue.create(:price_modifier => '4.44', :option_value => vanilla_icing_ov, :ad_hoc_option_type=>icing_pot)
AdHocOptionValue.create(:price_modifier => '5.55', :option_value => strawberry_icing_ov, :ad_hoc_option_type=>icing_pot)

