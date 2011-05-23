Order.class_eval do
  def add_variant(variant, ad_hoc_option_value_ids, product_customizations, quantity = 1)
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

      current_item.price   = variant.price + povs.map(&:price_modifier).compact.sum + product_customizations.map(&:price).sum
      self.line_items << current_item
    end

    # populate line_items attributes for additional_fields entries
    # that have populate => [:line_item]
    Variant.additional_fields.select{|f| !f[:populate].nil? && f[:populate].include?(:line_item) }.each do |field|
      value = ""

      if field[:only].nil? || field[:only].include?(:variant)
        value = variant.send(field[:name].gsub(" ", "_").downcase)
      elsif field[:only].include?(:product)
        value = variant.product.send(field[:name].gsub(" ", "_").downcase)
      end
      current_item.update_attribute(field[:name].gsub(" ", "_").downcase, value)
    end

    current_item
  end

  def contains?(variant, ad_hoc_option_value_ids, product_customizations)
    line_items.detect do |li|
      li.variant_id == variant.id &&
        matching_configurations(li.ad_hoc_option_values,ad_hoc_option_value_ids) &&
        matching_customizations(li.product_customizations,product_customizations)
    end
  end

  private

  # produces a list of [customizable_product_option.id,value] pairs for subsequent comparison
  def customization_pairs(product_customizations)
    pairs= product_customizations.map(&:customized_product_options).flatten.map do |m|
        [m.customizable_product_option.id, m.value]
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



#def ignore
#
#
#    # if neither is empty, we need to do a deeper inspection
#    if !li.customizations.empty? && !new_customizations.empty?
#
#      li.customizations.each do |cur_li_customization|
#
#        # find the matching customization in 'new_customizations', by 'type
#        cur_new_customization = new_customizations.detect { |nc| nc.customization_type_id == cur_li_customization.customization_type_id }
#
#        return false unless cur_new_customization
#
#        # at this point, the types are the same (e.g. we currently have an 'engraving' in the cart, and we are adding the same variant, which also has an 'engraving'.
#        # BUT, let's see ifi they are identical engravings, by looking at the customization values
#
#        # We need to an exact compare of these two:
#            # cur_li_customization.customized_product_options
#            # cur_new_customization.customized_product_options
#
#
#        cur_li_customization.all?
#        cur_new_customization.all?
#      end
#    else
#      # exactly one is empty, meaning NO MATCH
#      return false
#    end
#
#end
