OrdersController.class_eval do

  # Adds a new item to the order (creating a new order if none already exists)
  #
  # Parameters can be passed using the following possible parameter configurations:
  #
  # * Single variant/quantity pairing
  # +:variants => {variant_id => quantity}+
  #
  # * Multiple products at once
  # +:products => {product_id => variant_id, product_id => variant_id}, :quantity => quantity +
  # +:products => {product_id => variant_id, product_id => variant_id}}, :quantity => {variant_id => quantity, variant_id => quantity}+
  #
  # if has_variants 
  #   :quantity => 1
  # else 
  #   variants => {variant_id => 1}
  #
  def populate
    @order = current_order(true)

    params[:products].each do |product_id,variant_id|
      quantity = params[:quantity].to_i if !params[:quantity].is_a?(Hash)
      quantity = params[:quantity][variant_id].to_i if params[:quantity].is_a?(Hash)
      @order.add_variant(Variant.find(variant_id), quantity) if quantity > 0
    end if params[:products]
debugger

    # variant_id is (usually? / always) the MASTER variant_id
    params[:variants].each do |variant_id, quantity|

      quantity = quantity.to_i

      on_demand_option_values=[]
      # the incoming variant_id is the master variant.  Do we need to swap it out for an on-demand variant id?
      params[:product_option_types].each do |pot_id, pot_ov_id|
        on_demand_option_values << ProductOptionTypeOptionValue.find(pot_ov_id).option_value
      end if params[:product_option_types]

      if on_demand_option_values.empty?
        variant=Variant.find(variant_id)
      else
        variant=Variant.find_or_create_by_option_values(variant_id, on_demand_option_values)
      end

      @order.add_variant(variant, quantity) if quantity > 0
    end if params[:variants]


    redirect_to cart_path
  end
end
