Admin::OptionTypesController.class_eval do

  def configure
    # AJAX method for configuring an existing option type and associating with the current product
    @product = Product.find_by_param!(params[:product_id])
    @option_type = OptionType.find(params[:id])
    @product.option_types << @option_type

    @option_values=[]

    @option_type.option_values.each do |ov|
      @option_values << @product.product_option_values.create!(:option_value_id => ov.id)
    end

    @product.reload

    @option_types = @product.option_types

    set_available_option_types
  end

  def edit_configuration
    # method for configuring an existing option type that has already been associated with the current product
    @product = Product.find_by_param!(params[:product_id])
    @option_type = OptionType.find(params[:id])

    @option_types = @product.option_types
    set_available_option_types
  end

end
