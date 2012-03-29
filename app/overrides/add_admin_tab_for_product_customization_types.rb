Deface::Override.new(:virtual_path => "spree/admin/shared/_product_sub_menu",
                     :name => "converted_admin_product_sub_tabs_203014347",
                     :insert_bottom => "[data-hook='admin_product_sub_tabs'], #admin_product_sub_tabs[data-hook]",
                     :text => %{<%= tab :product_customization_types, :match_path => '/product_customization_types'})
