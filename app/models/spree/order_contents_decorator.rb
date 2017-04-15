module Spree
  OrderContents.class_eval do
    # Get current line item for variant if exists
    # Add variant qty to line_item
    def add(variant, quantity = 1, currency = nil, shipment = nil, ad_hoc_option_value_ids = [], product_customizations = [])
      line_item = order.find_line_item_by_variant(variant, ad_hoc_option_value_ids, product_customizations)
      add_to_line_item(line_item, variant, quantity, currency, shipment, ad_hoc_option_value_ids, product_customizations)
    end

    private
      def add_to_line_item(line_item, variant, quantity, currency=nil, shipment=nil, ad_hoc_option_value_ids = [], product_customizations = [])
        if line_item
          line_item.target_shipment = shipment
          line_item.quantity += quantity.to_i
          line_item.currency = currency unless currency.nil?
        else
          line_item = order.line_items.new(quantity: quantity, variant: variant)
          line_item.target_shipment = shipment

          product_customizations.map(&:save) # it is now safe to save the customizations we built

          line_item.product_customizations = product_customizations

          # find, and add the configurations, if any.  these have not been fetched from the db yet.              line_items.first.variant_id
          # we postponed it (performance reasons) until we actaully knew we needed them
          povs=[]
          ad_hoc_option_value_ids.each do |cid|
            povs << AdHocOptionValue.find(cid)
          end
          line_item.ad_hoc_option_values = povs

          offset_price   = povs.map(&:price_modifier).compact.sum + product_customizations.map {|pc| pc.price(variant)}.sum

          if currency
            line_item.currency = currency unless currency.nil?
            line_item.price    = variant.price_in(currency).amount + offset_price
          else
            line_item.price    = variant.price + adjusted_price
          end
        end
  
        line_item.save
        order.reload

        line_item
      end
  
  end
end
