class AddBackingClassNameToProductCustomizationTypes < ActiveRecord::Migration
  def change
   add_column :spree_product_customizations, :backing_class_id, :integer
   add_column :spree_product_customizations, :backing_class_type, :string
  end
end

