Deface::Override.new(:name => 'optional_customization_step_for_products_show',
                     :virtual_path => 'spree/products/show',
                     :replace => '[data-hook="cart_form"], #cart-form data-hook',
                     :partial => 'spree/products/optional_customization_step_for_products_show')

