Admin::OptionTypesController.class_eval do
  # not sure if I have to repeat the 'before_filter' for the original option_types account 
  before_filter :load_product, :only => [:selected, :available, :remove, :available_ad_hoc]

  def available_ad_hoc
    set_available_ad_hoc_option_types
    render :layout => false
  end

  # AJAX method for selecting an existing option type and associating with the current product
  def select_ad_hoc
    @product = Product.find_by_param!(params[:product_id])
    ad_hoc_option_type = AdHocOptionType.new(:product => @product, :option_type => OptionType.find(params[:id]))
    ad_hoc_option_type.save

    # now create an ad hoc option value (w/ TBD price_modifier) for every option value
    @product.reload

    ad_hoc_option_type.option_type.option_values.each do |ov|
      c=AdHocOptionValue.create(:option_value_id=>ov.id, :ad_hoc_option_type_id => ad_hoc_option_type.id)
      Rails.logger.debug("created #{c.id}")
    end

    redirect_to edit_admin_ad_hoc_option_type_url(ad_hoc_option_type)
  end


  private
    def set_available_ad_hoc_option_types
      @available_option_types = OptionType.all
      selected_option_types = []
      @product.ad_hoc_option_types.each do |option|
        selected_option_types << option.option_type
      end
      @available_option_types.delete_if {|ot| selected_option_types.include? ot}
    end

end
