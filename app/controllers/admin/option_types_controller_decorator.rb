Admin::OptionTypesController.class_eval do
  def select
    @product = Product.find_by_param!(params[:product_id])
    product_option_type = ProductOptionType.new(:product => @product, :option_type => OptionType.find(params[:id]))
    product_option_type.price_modifier_type= params[:price_modifier_type]
    product_option_type.is_required= params[:is_required]
    product_option_type.save
    @product.reload
    @option_types = @product.option_types
    set_available_option_types
  end
end
