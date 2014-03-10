    Deface::Override.new(:virtual_path => "spree/products/_cart_form",
                         :name => "converted_product_price_290656527",
                         :insert_before => "[data-hook='product_price'], #product_price[data-hook]",
                         :partial => "spree/products/customizations")
