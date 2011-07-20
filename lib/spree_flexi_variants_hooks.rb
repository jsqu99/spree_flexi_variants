class SpreeFlexiVariantsHooks < Spree::ThemeSupport::HookListener

  def self.perform_deface_customizations
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
    Deface::Override.new(:virtual_path => "admin/option_types/_option_value_fields",
                         :name => "option_value_price_1",
                         :insert_after => ".option_value.fields .presentation",
                         :partial => "admin/option_types/option_value_price",
                         :disabled => false)
    Deface::Override.new(:virtual_path => "admin/option_types/edit",
                         :name => "option_value_price_2",
                         :insert_after => "table.index thead tr th[2]",
                         :text => "<th>price</th>",
                         :disabled => false)
  end

  # detect if we have Deface support
  begin
    Deface::const_get "Deface"
    self.perform_deface_customizations
  rescue NameError
    # we are old-school spree (0.60.* and below)
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

end




