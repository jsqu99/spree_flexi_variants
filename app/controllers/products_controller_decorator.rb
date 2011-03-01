ProductsController.class_eval do
#  before_filter :load_option_types_for_on_demand_variants, :only => :show
#
#  def load_option_types_for_on_demand_variants
#    if @product.has_on_demand_variants?
#      @option_types= @product.option_types
#    end
#  end


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
  def populate
    @order = current_order(true)

    params[:products].each do |product_id,variant_id|
      quantity = params[:quantity].to_i if !params[:quantity].is_a?(Hash)
      quantity = params[:quantity][variant_id].to_i if params[:quantity].is_a?(Hash)
      @order.add_variant(Variant.find(variant_id), quantity) if quantity > 0
    end if params[:products]

    params[:variants].each do |variant_id, quantity|
      quantity = quantity.to_i
      @order.add_variant(Variant.find(variant_id), quantity) if quantity > 0
    end if params[:variants]

#  need to see what the parms look like before going any further
#    params[:option_values].each do |option_value_id, quantity|
#      quantity = quantity.to_i
#      @order.add_variant(Variant.find(variant_id), quantity) if quantity > 0
#    end if params[:variants]

    redirect_to cart_path
  end
end
