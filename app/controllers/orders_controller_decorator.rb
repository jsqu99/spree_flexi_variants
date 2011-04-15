OrdersController.class_eval do

  include ProductCustomizations


  # the inbound variant is determined either from products[pid]=vid or variants[master_vid], depending on whether or not the product has_variants, or not
  # 
  # Currently, we are assuming the inbound ad_hoc_option_values and customizations apply to the entire inbound product/variant 'group', as more surgery 
  # needs to occur in the cart partial for this to be done 'right' 
  #
  def populate
    @order = current_order(true)

    params[:products].each do |product_id,variant_id|
      quantity = params[:quantity].to_i if !params[:quantity].is_a?(Hash)
      quantity = params[:quantity][variant_id].to_i if params[:quantity].is_a?(Hash)
      @order.add_variant(Variant.find(variant_id), ad_hoc_option_value_ids, product_customizations, quantity) if quantity > 0
    end if params[:products]

    params[:variants].each do |variant_id, quantity|
      quantity = quantity.to_i
      @order.add_variant(Variant.find(variant_id), ad_hoc_option_value_ids, product_customizations, quantity) if quantity > 0
    end if params[:variants]

    redirect_to cart_path
  end


  private


  def ad_hoc_option_value_ids # (variant_id)
    ids=[]

    params[:ad_hoc_option_values].each do |ignore,pov_id|

      # pov=ProductOptionValue.find(pov_id)   # we don't actually need to load these from the DB just yet.  We might already have them attached to the line item

      # when it's a multi-select
      if pov_id.is_a?(Array)      
        pov_id.each do |p|
          ids << p unless p.empty?
        end
      else
        ids << pov_id unless pov_id.empty?
      end
    end if params[:ad_hoc_option_values]

    ids
  end

end

