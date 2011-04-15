class SpreeFlexiVariantsHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_product_sub_tabs, 'admin/products/additional_product_sub_menu'
  insert_after :admin_product_tabs, 'admin/products/additional_product_tabs'
  insert_after :product_price, 'products/ad_hoc_option_types'
  insert_after :product_price, 'products/customizations'

  insert_after :product_price, 'products/pricing'
  replace :order_details_line_item_row, 'shared/order_details_line_item_row'
  replace :cart_item_description, 'orders/cart_item_description'
  replace :admin_order_form_line_item_row, 'admin/orders/admin_order_form_line_item_row'

  insert_before :cart_form, 'products/content_for_head'
end
