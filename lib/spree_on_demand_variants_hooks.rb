class SpreeOnDemandVariantsHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_product_form_additional_fields, 'admin/products/has_on_demand_variants'
  insert_after :admin_product_sub_tabs, 'admin/products/option_values_tab'
end
