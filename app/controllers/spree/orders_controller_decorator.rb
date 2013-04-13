module Spree
  OrdersController.class_eval do

    # # the inbound variant is determined either from products[pid]=vid or variants[master_vid], depending on whether or not the product has_variants, or not
    # #
    # # Currently, we are assuming the inbound ad_hoc_option_values and customizations apply to the entire inbound product/variant 'group', as more surgery
    # # needs to occur in the cart partial for this to be done 'right'
    # #
    
    def populate
      populator = Spree::OrderPopulator.new(current_order(true), current_currency)
      if populator.populate(params.slice(:products, :variants, :quantity, :ad_hoc_option_values, :product_customizations))
        fire_event('spree.cart.add')
        fire_event('spree.order.contents_changed')
        respond_with(@order) do |format|
          format.html { redirect_to cart_path }
        end
      else
        flash[:error] = populator.errors.full_messages.join(" ")
        redirect_to :back
      end
    end

  end
end
