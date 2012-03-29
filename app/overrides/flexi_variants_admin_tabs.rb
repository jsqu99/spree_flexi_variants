Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "flexi_variants_admin_tabs",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<%= tab(:product_customization_types, :url => spree.admin_product_customization_types_path) %>")
