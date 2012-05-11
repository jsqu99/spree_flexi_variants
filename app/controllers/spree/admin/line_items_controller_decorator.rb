module Spree
  Admin::LineItemsController.class_eval do
    include ProductCustomizations
    include AdHocUtils

    def create
      variant = params[:add_variant_id] ? Variant.find(params[:add_variant_id]) : product.master
      if variant
        @order.add_variant(variant, params[:add_quantity].to_i, ad_hoc_option_value_ids, product_customizations)
      end
      if request.xhr?
        render :action => 'create', :layout => false
      else
        redirect_to edit_admin_order_path(@order)
      end
    end
  end
end
