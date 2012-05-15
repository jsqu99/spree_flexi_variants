module Spree
  Admin::LineItemsController.class_eval do
    include ProductCustomizations
    include AdHocUtils

    def create
      variant = Variant.find(params[:line_item][:variant_id])

      variant_configurations = CGI::parse params[:variant_configurations]

      # mess w/ the params object so we can reuse our helpers ... yeah, yeah, i know this isn't perfect.  send me a pull request.  i'll refactor at some point (not today)
      params[:ad_hoc_option_values] = {}
      variant_configurations.keys.each do |key|
        next unless key.start_with? 'ad_hoc_option_values['
        pov = variant_configurations[key]
        params[:ad_hoc_option_values][pov] = pov
      end
      
      # params[:product_customizations]
      @line_item = @order.add_variant(variant, params[:line_item][:quantity].to_i, ad_hoc_option_value_ids, product_customizations)

      if @order.save
        respond_with(@line_item) do |format|
          format.html { render :partial => 'spree/admin/orders/form', :locals => { :order => @order.reload }, :layout => false }
        end
      else
        respond_with(@line_item) do |format|
          format.js { render :action => 'create', :locals => { :order => @order.reload }, :layout => false }
        end
      end
    end
  end
end
