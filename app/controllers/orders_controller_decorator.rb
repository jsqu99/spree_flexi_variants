OrdersController.class_eval do

  include Customizations


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

end

