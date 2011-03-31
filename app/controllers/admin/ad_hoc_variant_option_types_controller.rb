class Admin::AdHocVariantOptionTypesController < Admin::ResourceController

  before_filter :load_product, :only => [:selected, :available, :remove]

  def edit
    @option_type = AdHocVariantOptionType.find(params[:id])  # whhy doensn't resource controller do this for me?
  end

  def update
    @option_type = AdHocVariantOptionType.find(params[:id]) 
    params[:price_modifier].each_pair do |option_value_id, price_modifier|
      # TODO need to ensure price_modifier is a decimal
      AdHocVariantOptionValue.create(:option_value_id=>option_value_id, :ad_hoc_variant_option_type_id => @option_type.id, :price_modifier=>price_modifier)
    end

    redirect_to selected_admin_product_ad_hoc_variant_option_types_url(@product)
  end

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
    # need this to determine which set of option values to show
#    @last_selected_option_type_id=params[:id]
    @product = Product.find_by_param!(params[:product_id])
    ad_hoc_variant_option_type = AdHocVariantOptionType.new(:product => @product, :option_type => OptionType.find(params[:id]))
    ad_hoc_variant_option_type.save
    @product.reload
    # @option_types = @product.ad_hoc_variant_option_types
    # set_available_option_types

    # now redirect to the 
    @option_type=ad_hoc_variant_option_type 
    redirect_to edit_admin_product_ad_hoc_variant_option_type_url(@product, @option_type)
#    render :action=> "edit"
  end

  protected
    
    def location_after_save
      if @ad_hoc_variant_option_type.created_at == @ad_hoc_variant_option_type.updated_at
        edit_admin_product_ad_hoc_variant_option_type_url(@product, @ad_hoc_variant_option_type)
      else
        admin_product_ad_hoc_variant_option_types_url(@product) # TODO: is this right?
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
