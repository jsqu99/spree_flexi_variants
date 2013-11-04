Deface::Override.new(:virtual_path => "spree/products/_cart_form",
                     :name => "fix_cart_form_columnization_remove_column_classes",
                     :remove_from_attributes => '#product-variants, [data-hook=product_price]',
                     :attributes => {:class => 'columns'})