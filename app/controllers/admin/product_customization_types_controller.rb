class Admin::ProductCustomizationTypesController < Admin::ResourceController
  before_filter :load_product, :only => [:selected, :available, :remove]
  before_filter :load_calculator, :only => [:new,:edit]

  def load_calculator
    @calculators = ProductCustomizationType.calculators.sort_by(&:name)
  end
  def available
    set_available_product_customization_types
    render :layout => false
  end

  def selected
    @product_customization_types = @product.product_customization_types
  end

  def remove
    @product.product_customization_types.delete(@product_customization_type)
    @product.save
    flash.notice = I18n.t("notice_messages.product_customization_type_removed")
    redirect_to selected_admin_product_product_customization_types_url(@product)
  end

#  def update_positions
#    params[:positions].each do |id, index|
#      ProductCustomizationType.update_all(['position=?', index], ['id=?', id])
#    end
#    
#    respond_to do |format|
#      format.html { redirect_to admin_product_variants_url(params[:product_id]) }
#      format.js  { render :text => 'Ok' }
#    end
#  end

  # AJAX method for selecting an existing option type and associating with the current product
  def select
    @product = Product.find_by_param!(params[:product_id])
#    product_product_customization_type = ProductProductCustomizationType.new(:product => @product, :product_customization_type => ProductCustomizationType.find(params[:id]))

    @product.product_customization_types << ProductCustomizationType.find(params[:id])
    @product.save 
    @product_customization_types = @product.product_customization_types
    set_available_product_customization_types
  end

  protected
    
    def location_after_save
      if params[:action] == "update"
        admin_product_customization_types_url
      else
        edit_admin_product_customization_type_url(@product_customization_type)
      end
    end


  private
    def load_product
      @product = Product.find_by_param!(params[:product_id])
    end
  
    def set_available_product_customization_types
      @available_product_customization_types = ProductCustomizationType.all
      selected_product_customization_types = []
      @product.product_customization_types.each do |pct|
        selected_product_customization_types << pct
      end
      @available_product_customization_types.delete_if {|pct| selected_product_customization_types.include? pct}
    end
end
