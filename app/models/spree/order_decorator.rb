module Spree
  Order.class_eval do
    def add_variant(variant, quantity = 1, ad_hoc_option_value_ids=[], product_customizations=[])
      current_item = contains?(variant, ad_hoc_option_value_ids, product_customizations)
      if current_item
        current_item.quantity += quantity
        current_item.save
      else
        current_item = LineItem.new(:quantity => quantity)
        current_item.variant = variant

        # add the product_customizations, if any
        # TODO: is this an unnecessary step?
        product_customizations.map(&:save) # it is now safe to save the customizations we created in the OrdersController.populate

        current_item.product_customizations = product_customizations

        # find, and add the configurations, if any.  these have not been fetched from the db yet.              line_items.first.variant_id
        # we postponed it (performance reasons) until we actaully knew we needed them
        povs=[]
        ad_hoc_option_value_ids.each do |cid|
          povs << AdHocOptionValue.find(cid)
        end
        current_item.ad_hoc_option_values = povs

        current_item.price   = variant.price + povs.map(&:price_modifier).compact.sum + product_customizations.map {|pc| pc.price(variant)}.sum
        self.line_items << current_item
      end
      
      self.reload
      current_item
    end

    def contains?(variant, ad_hoc_option_value_ids, product_customizations)
      line_items.detect do |li|
        li.variant_id == variant.id &&
          matching_configurations(li.ad_hoc_option_values,ad_hoc_option_value_ids) &&
          matching_customizations(li.product_customizations,product_customizations)
      end
    end

    def merge!(order)
      order.line_items.each do |line_item|
        self.add_variant(line_item.variant, line_item.quantity, line_item.ad_hoc_option_value_ids, line_item.product_customizations)
      end
      order.destroy
    end

    private

    # produces a list of [customizable_product_option.id,value] pairs for subsequent comparison
    def customization_pairs(product_customizations)
      pairs= product_customizations.map(&:customized_product_options).flatten.map do |m|
        [m.customizable_product_option.id, m.value.present? ? m.value : m.customization_image.to_s ]
      end

      Set.new pairs
    end

    def matching_configurations(existing_povs,new_povs)
      # if there aren't any povs, there's a 'match'
      return true if existing_povs.empty? && new_povs.empty?

      existing_povs.map(&:id).sort == new_povs.map(&:to_i).sort
    end

    def matching_customizations(existing_customizations,new_customizations)

      # if there aren't any customizations, there's a 'match'
      return true if existing_customizations.empty? && new_customizations.empty?

      # exact match of all customization types?
      return false unless existing_customizations.map(&:product_customization_type_id).sort == new_customizations.map(&:product_customization_type_id).sort

      # get a list of [customizable_product_option.id,value] pairs
      existing_vals = customization_pairs existing_customizations
      new_vals      = customization_pairs new_customizations

      # do a set-compare here
      existing_vals == new_vals
    end
  end
end
