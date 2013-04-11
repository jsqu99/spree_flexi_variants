module ProductCustomizations

  # given params[:customizations], return a non-persisted array of ProductCustomization objects
  def product_customizations(product_customizations_hash)
    customizations=[]

    # do we have any customizations?
    product_customizations_hash.each do |ct_id,cv_pair|  # customization_type_id =>
      # {customized_product_option_id => <user input>,  etc.}
      next if cv_pair.empty? || cv_pair.values.all? {|v| v.empty?}
      # create a product_customization based on ct_id
      pc=Spree::ProductCustomization.new(:product_customization_type_id => ct_id)

      cv_pair.each_pair do |cust_opt_id, user_input|
        # create a customized_product_option based on cust_opt_id
        cpo=Spree::CustomizedProductOption.new
        # attach to its 'type'
        cpo.customizable_product_option_id= cust_opt_id

        if user_input.is_a? String
          cpo.value = user_input
        else
          cpo.value = "" # TODO revisit. What should be here
          cpo.customization_image = user_input["customization_image"]
        end
        # attach to its customization
        pc.customized_product_options << cpo
      end

      customizations << pc

    end if product_customizations_hash

    customizations
  end

end
