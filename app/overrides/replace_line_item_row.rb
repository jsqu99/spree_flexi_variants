Deface::Override.new(:virtual_path => "shared/_order_details",
                     :name => "converted_order_details_line_item_row_27877400",
                     :replace => "[data-hook='order_details_line_item_row'], #order_details_line_item_row[data-hook]",
                     :partial => "shared/order_details_line_item_row",
                     :disabled => false)

Deface::Override.new(:virtual_path => "orders/_line_item",
                     :name => "converted_line_item_price_1234",
                     :replace => "[data-hook='cart_item_price']",
                     :text => %q(
                       <td>
                         <%= number_to_currency line_item.price %>
                       </td>
                     ))

Deface::Override.new(:virtual_path => "orders/_line_item",
                     :name => "converted_line_item_total_456",
                     :replace => "[data-hook='cart_item_total']",
                     :text => %q(
                       <td>
                         <%= number_to_currency (line_item.price * line_item.quantity) %>
                       </td>
                     ))


