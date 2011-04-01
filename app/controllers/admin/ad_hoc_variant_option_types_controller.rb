class Admin::AdHocVariantOptionTypesController < Admin::ResourceController

  before_filter :load_product, :only => [:selected, :available, :remove]

#  def edit
#    @option_type = AdHocVariantOptionType.find(params[:id])  # whhy doesn't the new resource controller do this for me?
#
#    # now what I want to do is initialize a group of option_values & ad_hoc_option_values
#    # 
#    # every option_value is always displayed.  There may or may not already be a 'mirroring' ad_hoc_option_value
#
#    @option_values = @option_type.option_type.option_values
#    
#    # add all of these to a hash
#    @ov_assignments=Hash.new
#
#    # link an ov to its ad_hoc_ov
#    @option_type.option_values.each {|ahov| @ov_assignments[ahov.option_value.id] = ahov.id} 
#  end
#
#  def overkill_edit
#    @option_type = AdHocVariantOptionType.find(params[:id])  # whhy doesn't the new resource controller do this for me?
#
#    # now what I want to do is initialize a group of option_values & ad_hoc_option_values
#    # 
#    # every option_value is always displayed.  There may or may not already be a 'mirroring' ad_hoc_option_value
#
#    @option_values = @option_type.option_type.option_values
#    
#    # add all of these to a hash
#    @ov_assignments=Hash.new
#
#    # link an ov to its ad_hoc_ov
#    @option_type.option_values.each {|ahov| @ov_assignments[ahov.option_value.id] = ahov.id} 
#  end
#
#  def update
#    @option_type = AdHocVariantOptionType.find(params[:id]) 
#    params[:price_modifier].each_pair do |option_value_id, price_modifier|
#      # TODO need to ensure price_modifier is a decimal
#      AdHocVariantOptionValue.create(:option_value_id=>option_value_id, :ad_hoc_variant_option_type_id => @option_type.id, :price_modifier=>price_modifier)
#    end
#
#    redirect_to selected_admin_product_ad_hoc_variant_option_types_url(@product)
#  end
#
  def available
    set_available_option_types
    render :layout => false
  end

  def selected
    @option_types = @product.ad_hoc_variant_option_types
  end

  def remove
    @product.ad_hoc_variant_option_types.delete(@ad_hoc_variant_option_type)
    @product.save
    flash.notice = I18n.t("notice_messages.option_type_removed")
    redirect_to selected_admin_product_ad_hoc_variant_option_types_url(@product)
  end

  # AJAX method for selecting an existing option type and associating with the current product
  def select
    @product = Product.find_by_param!(params[:product_id])
    ad_hoc_variant_option_type = AdHocVariantOptionType.new(:product => @product, :option_type => OptionType.find(params[:id]))
    ad_hoc_variant_option_type.save

    # now create an ad hoc option value (w/ TBD price_modifier) for every option value
    @product.reload

    ad_hoc_variant_option_type.option_type.option_values.each do |ov|
      c=AdHocVariantOptionValue.create(:option_value_id=>ov.id, :ad_hoc_variant_option_type_id => ad_hoc_variant_option_type.id)
      Rails.logger.debug("created #{c.id}")
    end

    redirect_to edit_admin_ad_hoc_variant_option_type_url(ad_hoc_variant_option_type)
  end

  protected
    
    def location_after_save
      if @ad_hoc_variant_option_type.created_at == @ad_hoc_variant_option_type.updated_at
        selected_admin_product_ad_hoc_variant_option_types_url(@ad_hoc_variant_option_type.product)
      else
        # removed 'product' from below...correct? product_
        # admin_product_ad_hoc_variant_option_types_url(@product) # TODO: is this right?

        admin_ad_hoc_variant_option_types_url # TODO: is this right?
      end
    end


  private
    def load_product
      @product = Product.find_by_param!(params[:product_id])
    end
  
    def set_available_option_types
      @available_option_types = OptionType.all
      selected_option_types = []
      @product.ad_hoc_variant_option_types.each do |option|
        selected_option_types << option.option_type
      end
      @available_option_types.delete_if {|ot| selected_option_types.include? ot}
    end
end
