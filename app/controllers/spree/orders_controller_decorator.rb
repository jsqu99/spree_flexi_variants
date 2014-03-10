module Spree
  OrdersController.class_eval do

    include ProductCustomizations
    include AdHocUtils

    # the inbound variant is determined either from products[pid]=vid or variants[master_vid], depending on whether or not the product has_variants, or not
    #
    # Currently, we are assuming the inbound ad_hoc_option_values and customizations apply to the entire inbound product/variant 'group', as more surgery
    # needs to occur in the cart partial for this to be done 'right'
    #
    # Adds a new item to the order (creating a new order if none already exists)
    def populate
      populator = Spree::OrderPopulator.new(current_order(create_order_if_necessary: true), current_currency)
      flexi_hash = {ad_hoc_option_value_ids: ad_hoc_option_value_ids, product_customizations: product_customizations}

      if populator.populate(params.slice(:products, :variants, :quantity).merge(flexi_hash))
        current_order.ensure_updated_shipments

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
