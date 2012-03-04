Deface::Override.new(:virtual_path => "spree/shared/_order_details",
                     :name => "add_extra_order_details_line_item_description",
                     :insert_bottom => "[data-hook='order_item_description']",
                     :partial => "spree/shared/extra_order_details_line_item_description",
                     :disabled => false)

