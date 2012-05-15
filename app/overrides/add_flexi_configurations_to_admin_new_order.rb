Deface::Override.new(:virtual_path => 'spree/admin/orders/_add_product',
                     :name => 'add_flexi_configurations_to_admin_new_order',
                     :insert_after => '[data-hook="add_button"]',
                     :text => %(
    <div id="configurations" style="float: left; width:55%;margin-right:5%; margin-top: 30px; margin-left: 10%;"></div>))
