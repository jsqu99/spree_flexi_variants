class SpreeOnDemandVariantsHooks < Spree::ThemeSupport::HookListener
#  insert_after :admin_product_form_additional_fields, 'admin/products/has_on_demand_variants'
  insert_after :admin_product_sub_tabs, 'admin/products/additional_product_sub_tabs'
  insert_after :admin_product_tabs, 'admin/products/additional_product_tabs'
  insert_after :product_price, 'products/customizations'
end
