module Spree
  OrderPopulator.class_eval do

    def populate(variant_id, quantity, ad_hoc_option_value_ids = [], product_customizations = [])
      attempt_cart_add(variant_id, quantity, ad_hoc_option_value_ids, product_customizations)
      valid?
    end

    private

    def attempt_cart_add(variant_id, quantity, ad_hoc_option_value_ids, product_customizations)
      quantity = quantity.to_i
      # 2,147,483,647 is crazy.
      # See issue #2695.
      if quantity > 2_147_483_647
        errors.add(:base, Spree.t(:please_enter_reasonable_quantity, :scope => :order_populator))
        return false
      end

      variant = Spree::Variant.find(variant_id)
      if quantity > 0
        line_item = @order.contents.add(variant, quantity, currency, nil, ad_hoc_option_value_ids, product_customizations)
        unless line_item.valid?
          errors.add(:base, line_item.errors.messages.values.join(" "))
          return false
        end
      end
    end
  end
end
