Deface::Override.new(:virtual_path => "spree/products/_cart_form",
                         :name => "converted_product_price_331970321",
                         :insert_after => "[data-hook='product_price'], #product_price[data-hook]",
                         :partial => "spree/products/pricing")
