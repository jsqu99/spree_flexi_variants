OrdersController.class_eval do

  # the inbound variant is determined either from products[pid]=vid or variants[master_vid], depending on whether or not the product has_variants, or not
  # 
  # Currently, we are assuming the inbound product_option_values and customizations apply to the entire inbound product/variant 'group', as more surgery 
  # needs to occur in the cart partial for this to be done 'right' 
  #
  def populate
    @order = current_order(true)

    params[:products].each do |product_id,variant_id|
      quantity = params[:quantity].to_i if !params[:quantity].is_a?(Hash)
      quantity = params[:quantity][variant_id].to_i if params[:quantity].is_a?(Hash)
      @order.add_variant(Variant.find(variant_id), product_option_value_ids, customizations, quantity) if quantity > 0
    end if params[:products]

    params[:variants].each do |variant_id, quantity|
      quantity = quantity.to_i
      @order.add_variant(Variant.find(variant_id), product_option_value_ids, customizations, quantity) if quantity > 0
    end if params[:variants]

    redirect_to cart_path
  end


  private


  def product_option_value_ids # (variant_id)
    ids=[]

    params[:product_option_values].each do |ignore,pov_id|
      # pov=ProductOptionValue.find(pov_id)   # we don't actually need to load these from the DB just yet.  We might already have them attached to the line item
      ids << pov_id
    end if params[:product_option_values]

    ids
  end

  def customizations # (variant_id)
    customizations=[]

    # do we have any customizations?
    params[:customizations].each do |ct_id,cv_pair|  # customization_type_id => 
      # {customized_product_option_id => <user input>,  etc.}

      next if cv_pair.empty?
      # create a product_customization based on ct_id
      pc=Customization.new(:customization_type_id => ct_id)
      
      cv_pair.each_pair do |cust_opt_id, user_input|
        # create a customized_product_option based on cust_opt_id
        cpo=CustomizedProductOption.new
        # attach to its 'type'
        cpo.customizable_product_option_id= cust_opt_id
        cpo.value = user_input
        # attach to its customization
        pc.customized_product_options << cpo
        # cpo.customization=pc
      end

      # Rails.logger.debug "computed price of customization: #{pc.id} - #{pc.customization_type.calculator.description}: #{pc.price}"

      customizations << pc

    end if params[:customizations]

    customizations
  end
end

