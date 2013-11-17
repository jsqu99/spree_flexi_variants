class AddBackingClassNameToProductCustomizationTypes < ActiveRecord::Migration
  def change
   add_column :spree_product_customization_types, :backing_class_name, :string
  end
end

