module Customizations

  # given params[:customizations], return a non-persisted array of Customization objects
  def customizations
    customizations=[]

    # do we have any customizations?
    params[:customizations].each do |ct_id,cv_pair|  # customization_type_id => 
      # {customized_product_option_id => <user input>,  etc.}

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

    end if params[:customizations]

    customizations
  end

end
