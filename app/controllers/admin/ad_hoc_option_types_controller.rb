class Admin::AdHocOptionTypesController < Admin::ResourceController

  before_filter :load_product, :only => [:selected]

  def selected
    @option_types = @product.ad_hoc_option_types
  end

  def remove
    # TODO: when removing an option type, we need to check if removing the option type from an
    # associated exclusion causes the exclusion to only have one member.  If so, we'll need to
    # remove the entire exclusion
    @product=@ad_hoc_option_type.product
    @ad_hoc_option_type.destroy
    flash.notice = I18n.t("notice_messages.option_type_removed")
    redirect_to selected_admin_product_ad_hoc_option_types_url(@product)
  end

  protected
    def location_after_save
      selected_admin_product_ad_hoc_option_types_url(@ad_hoc_option_type.product)
    end

  private
    def load_product
      @product = Product.find_by_param!(params[:product_id])
    end

end
