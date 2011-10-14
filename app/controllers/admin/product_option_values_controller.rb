class Admin::ProductOptionValuesController < Admin::ResourceController

  # AJAX method for selecting an existing option type and associating with the current product
  def select
    @product = Product.find_by_param!(params[:product_id])
    @product.option_types << OptionType.find(params[:id])
    @product.reload
    @option_types = @product.option_types
    set_available_option_types
  end

  # AJAX method for removing an existing option value from the current product
  def remove
    @product_option_value.destroy
  end
end
