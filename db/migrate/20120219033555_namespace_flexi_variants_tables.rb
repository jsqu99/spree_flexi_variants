class NamespaceFlexiVariantsTables < ActiveRecord::Migration
  def up
    rename_table :ad_hoc_option_types                  ,   :spree_ad_hoc_option_types
    rename_table :ad_hoc_option_values                 ,   :spree_ad_hoc_option_values
    rename_table :product_customizations               ,   :spree_product_customizations
    rename_table :product_customization_types          ,   :spree_product_customization_types
    rename_table :ad_hoc_variant_exclusions            ,   :spree_ad_hoc_variant_exclusions
    rename_table :customized_product_options           ,   :spree_customized_product_options
    rename_table :customizable_product_options         ,   :spree_customizable_product_options
    rename_table :excluded_ad_hoc_option_values        ,   :spree_excluded_ad_hoc_option_values
    rename_table :ad_hoc_option_values_line_items      ,   :spree_ad_hoc_option_values_line_items
  end

  def down
    rename_table :spree_ad_hoc_option_types                  ,   :ad_hoc_option_types
    rename_table :spree_ad_hoc_option_values                 ,   :ad_hoc_option_values
    rename_table :spree_product_customizations               ,   :product_customizations
    rename_table :spree_product_customization_types          ,   :product_customization_types
    rename_table :spree_ad_hoc_variant_exclusions            ,   :ad_hoc_variant_exclusions
    rename_table :spree_customized_product_options           ,   :customized_product_options
    rename_table :spree_customizable_product_options         ,   :customizable_product_options
    rename_table :spree_excluded_ad_hoc_option_values        ,   :excluded_ad_hoc_option_values
    rename_table :spree_ad_hoc_option_values_line_items      ,   :ad_hoc_option_values_line_items
  end
end
