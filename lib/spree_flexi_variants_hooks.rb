class SpreeFlexiVariantsHooks < Spree::ThemeSupport::HookListener
  Deface::Override.new(:virtual_path => "admin/shared/_product_sub_menu",
                       :name => "converted_admin_product_sub_tabs_203014347",
                       :insert_bottom => "[data-hook='admin_product_sub_tabs'], #admin_product_sub_tabs[data-hook]",
                       :partial => "admin/products/additional_product_sub_menu",
                       :disabled => false)
  Deface::Override.new(:virtual_path => "admin/shared/_product_tabs",
                       :name => "converted_admin_product_tabs_983418929",
                       :insert_bottom => "[data-hook='admin_product_tabs'], #admin_product_tabs[data-hook]",
                       :partial => "admin/products/additional_product_tabs",
                       :disabled => false)
  Deface::Override.new(:virtual_path => "products/_cart_form",
                       :name => "converted_product_price_733808074",
                       :insert_after => "[data-hook='product_price'], #product_price[data-hook]",
                       :partial => "products/ad_hoc_option_types",
                       :disabled => false)
  Deface::Override.new(:virtual_path => "products/_cart_form",
                       :name => "converted_product_price_290656527",
                       :insert_after => "[data-hook='product_price'], #product_price[data-hook]",
                       :partial => "products/customizations",
                       :disabled => false)
  Deface::Override.new(:virtual_path => "products/_cart_form",
                       :name => "converted_product_price_331970321",
                       :insert_after => "[data-hook='product_price'], #product_price[data-hook]",
                       :partial => "products/pricing",
                       :disabled => false)
  Deface::Override.new(:virtual_path => "shared/_order_details",
                       :name => "converted_order_details_line_item_row_27877400",
                       :replace => "[data-hook='order_details_line_item_row'], #order_details_line_item_row[data-hook]",
                       :partial => "shared/order_details_line_item_row",
                       :disabled => false)
  Deface::Override.new(:virtual_path => "orders/_line_item",
                       :name => "converted_cart_item_description_722158932",
                       :insert_bottom => "[data-hook='cart_item_description'], #cart_item_description[data-hook]",
                       :partial => "orders/cart_item_description",
                       :disabled => false)
  Deface::Override.new(:virtual_path => "admin/orders/_line_item",
                       :name => "converted_admin_order_form_line_item_row_459848395",
                       :replace => "[data-hook='admin_order_form_line_item_row'], #admin_order_form_line_item_row[data-hook]",
                       :partial => "admin/orders/admin_order_form_line_item_row",
                       :disabled => false)
  Deface::Override.new(:virtual_path => "products/show",
                       :name => "converted_cart_form_594755007",
                       :insert_before => "[data-hook='cart_form'], #cart_form[data-hook]",
                       :partial => "products/content_for_head",
                       :disabled => false)
end
