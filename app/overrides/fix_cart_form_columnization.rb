Deface::Override.new(:virtual_path => "spree/products/_cart_form",
                     :name => "fix_cart_form_columnization_remove_column_classes",
                     :set_attributes => '.columns',
                     :remove_from_attributes => %w{class})