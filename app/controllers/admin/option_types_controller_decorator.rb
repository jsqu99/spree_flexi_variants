Admin::OptionTypesController.class_eval do

  before_filter :create_option_pricing_configuration, :only => :update

  update_response =  lambda { render configure_dynamic_admin_option_type_path(@option_type) }

  respond_override :update => { :html =>  { :success => update_response }}
  respond_override :update => { :html =>  { :failure => update_response }}

  # 'global' option type configuration
  def configure_dynamic
    # AJAX method for configuring an existing option type to be used as defaults for all products
    @option_type = OptionType.find(params[:id])
    @option_values= @option_type.option_values
  end

  # 'per-product' option type configuration
  def configure_dynamic_for_product
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

  def edit_dynamic_for_product
    # method for configuring an existing option type that has already been associated with the current product
    @product = Product.find_by_param!(params[:product_id])
    @option_type = OptionType.find(params[:id])

    @option_values= @product.product_option_values

    @option_types = @product.option_types
    set_available_option_types
  end

  private
  def create_option_pricing_configuration
    klass = params[object_name].delete('option_pricing_configuration').constantize
    @option_type.option_pricing_configuration = klass.new
  end
end
