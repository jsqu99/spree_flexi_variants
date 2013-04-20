class AddTenantIdToSpreeFlexiVariantsModels < ActiveRecord::Migration
  def change
    add_column :spree_ad_hoc_option_types,             :tenant_id, :spree_integer
    add_column :spree_ad_hoc_option_values,            :tenant_id, :spree_integer
    add_column :spree_ad_hoc_option_values_line_items, :tenant_id, :spree_integer
    add_column :spree_ad_hoc_variant_exclusions,       :tenant_id, :spree_integer
    add_column :spree_customizable_product_options,    :tenant_id, :spree_integer
    add_column :spree_customized_product_options,      :tenant_id, :spree_integer
    add_column :spree_excluded_ad_hoc_option_values,   :tenant_id, :spree_integer
    add_column :spree_product_customizations,          :tenant_id, :spree_integer
    add_column :spree_product_customization_types,     :tenant_id, :spree_integer
  end
end
