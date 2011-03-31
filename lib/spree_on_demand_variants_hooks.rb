class SpreeOnDemandVariantsHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_product_sub_tabs, 'admin/products/additional_product_sub_menu'
  insert_after :admin_product_tabs, 'admin/products/additional_product_tabs'
  insert_after :product_price, 'products/ad_hoc_variant_option_types'
  insert_after :product_price, 'products/customizations'
  insert_after :product_price, 'products/pricing'
  insert_after :cart_item_description, 'orders/line_item_extra_description'
end
