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

    # create, but don't yet persist, conf/cust objects, if any are present
    configurations,customizations = create_configurations,create_customizations

    params[:products].each do |product_id,variant_id|
      quantity = params[:quantity].to_i if !params[:quantity].is_a?(Hash)
      quantity = params[:quantity][variant_id].to_i if params[:quantity].is_a?(Hash)
      @order.add_variant(Variant.find(variant_id), configurations, customizations, quantity) if quantity > 0
    end if params[:products]

    # variant_id is (usually? / always) the MASTER variant_id
    params[:variants].each do |variant_id, quantity|

      quantity = quantity.to_i

      ov_config=[]  # ov_config = option_value_configs
      # the incoming variant_id is the master variant.  Do we need to swap it out for an on-demand variant id?
#      params[:product_option_types][:option_value_configs].each do |pot_id, ov_config_id|
      params[:product_option_types].each do |pot_id, ov_config_id|
        next if ov_config_id.empty?
        ov_config << OptionValueConfig.find(ov_config_id)
      end if params[:product_option_types]

      # params[:product_option_types][customization_values].each do |pot_id, customization_value|

      if ov_config.empty? # and customization_values is empty?
        variant=Variant.find(variant_id)

        # if we have a customization_value, then...what?

      else

        # now takes a hash?   :option_value_config{1=>4}, :customization_value=>{2=>"my dog has fleas"}
        variant=Variant.find_or_create_by_option_values(ov_config)
      end

      @order.add_variant(variant, quantity) if quantity > 0
    end if params[:variants]


    redirect_to cart_path
  end


  private

  def create_configurations
    configurations=[]
  end

  def create_customizations
    customizations=[]

    # do we have any customizations?
    params[:customization_type].each do |ct_id, cv_pair|
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
    end if params[:customization_type]

    customizations
  end
end

