module Spree
  class Admin::AdHocOptionTypesController < Admin::ResourceController

    before_filter :load_product, :only => [:selected]
    before_filter :load_available_option_values, :only => [:edit]

    def selected
      @option_types = @product.ad_hoc_option_types
    end

    def add_option_value
      @ad_hoc_option_type.ad_hoc_option_values.create!(option_value_id: params[:option_value_id])
      redirect_to edit_admin_product_ad_hoc_option_type_url(@ad_hoc_option_type.product, @ad_hoc_option_type)
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

    def load_available_option_values
      @available_option_values = @ad_hoc_option_type.option_type.option_values - @ad_hoc_option_type.ad_hoc_option_values.map(&:option_value)
    end
  end
end
