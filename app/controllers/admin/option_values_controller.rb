class Admin::OptionValuesController < Admin::BaseController
  resource_controller

  before_filter :load_object, :only => [:selected, :available, :remove]
  belongs_to :product_option_type

  def available
    set_available_option_values
    render :layout => false
  end

  def selected
    @product=@product_option_type.product
    @option_values=@product_option_type.product_option_type_option_values
    set_available_option_values
  end

  def remove
    @product_option_type.option_values.delete(@option_value)
    @product_option_type.save
    flash.notice = I18n.t("notice_messages.option_value_removed")
    redirect_to selected_admin_product_option_type_option_values_url(@product_option_type)
  end

  new_action.response do |wants|
    wants.html {render :action => :new, :layout => !request.xhr?}
  end

  # redirect to index (instead of r_c default of show view)
  create.response do |wants|
    wants.html {redirect_to edit_object_url}
  end

  # redirect to index (instead of r_c default of show view)
  update.response do |wants|
    wants.html {redirect_to collection_url}
  end

  destroy.success.wants.js { render_js_for_destroy }

#  # AJAX method for selecting an existing option value and associating with the current product
  def select
    @product_option_type = ProductOptionType.find(params[:product_option_type_id])

    product_option_type_option_value = ProductOptionTypeOptionValue.create(
                                                                           :product_option_type => @product_option_type, 
                                                                           :option_value => OptionValue.find(params[:id]), 
                                                                           :price_modifier => params[:price_modifier])

    @product_option_type.reload # TODO: is this line necessary?
    @option_values=@product_option_type.product_option_type_option_values
    set_available_option_values
  end

  private
    def set_available_option_values
      # all option values for a product
      @available_option_values = @product_option_type.option_type.option_values 
      selected_option_values = []

      @product_option_type.option_values.each do |ov|
        selected_option_values << ov
      end
      @available_option_values.delete_if {|ov| selected_option_values.include? ov}
    end
end

