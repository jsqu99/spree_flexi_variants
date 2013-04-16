module Spree
  OrderPopulator.class_eval do

    include ProductCustomizations
    include AdHocUtils
    
    def populate(from_hash)
      from_hash[:products].each do |product_id,variant_id|
        attempt_cart_add( variant_id, 
                          from_hash[:quantity], 
                          ad_hoc_option_value_ids(from_hash[:ad_hoc_option_values]), 
                          product_customizations(from_hash[:product_customizations])
                         )
      end if from_hash[:products]

      from_hash[:variants].each do |variant_id, quantity|
        attempt_cart_add( variant_id, 
                          quantity, 
                          ad_hoc_option_value_ids(from_hash[:ad_hoc_option_values]), 
                          product_customizations(from_hash[:product_customizations])
                         )
      end if from_hash[:variants]

      valid?
    end
    private

    def attempt_cart_add(variant_id, quantity, ad_hoc_option_value_ids, product_customizations)
      quantity = quantity.to_i
      if quantity > Spree::Config[:max_quantity]
        errors.add(:base, %Q{Please enter a reasonable quantity.})
        return false
      end

      variant = Spree::Variant.find(variant_id)
      if quantity > 0
        if check_stock_levels(variant, quantity)
          @order.add_variant(variant, quantity, ad_hoc_option_value_ids, product_customizations)
        end
      end
    end

  end
end