# Create a 'Custom Frame" product
frame = Product.create(:name => 'Custom Frame', :price => 10, :available_on => Time.now)

# A frame can be one of many types of metals (e.g. gold, silver, etc.)
finish_ot = OptionType.create(:name => 'finish', :presentation => 'Finish')

gold_ov   = OptionValue.create(:option_type => finish_ot, :name => 'gold'  , :presentation => 'Gold')
silver_ov = OptionValue.create(:option_type => finish_ot, :name => 'silver', :presentation => 'Silver')


# Create two frame variants

gold_variant = Variant.create(:product=>frame)   
gold_variant.option_values << gold_ov

silver_variant = Variant.create(:product=>frame) 
silver_variant.option_values << silver_ov


ct= ProductCustomizationType.create(:name => "frame_dimensions", :presentation => "Enter Width/Height")
ct.products << frame
dim_calc    = Calculator::ProductArea.new(:preferred_multiplier => 3.0,
 	                                          :preferred_min_width => 4,
 	                                          :preferred_max_width => 90,
 	                                          :preferred_min_height => 4,
 	                                          :preferred_max_height => 90
                                          )
ct.calculator=dim_calc
ct.customizable_product_options << CustomizableProductOption.create(:name => "width", :presentation => 'Width (inches)', :data_type => "decimal", :is_required=>true)
ct.customizable_product_options << CustomizableProductOption.create(:name => "height", :presentation => 'Height (inches)', :data_type => "decimal", :is_required=>true)


