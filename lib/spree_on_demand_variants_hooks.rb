class SpreeOnDemandVariantsHooks < Spree::ThemeSupport::HookListener
#  insert_after :admin_product_form_additional_fields, 'admin/products/has_on_demand_variants'
  insert_after :admin_product_sub_tabs, 'admin/products/additional_product_sub_tabs'
  insert_after :admin_product_tabs, 'admin/products/additional_product_tabs'
  insert_after :product_price, 'products/product_option_types'
  insert_after :product_price, 'products/customizations'
  insert_after :product_price, 'products/pricing'
  insert_after :cart_item_description, 'orders/line_item_extra_description'
end
