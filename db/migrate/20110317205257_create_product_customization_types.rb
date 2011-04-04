class CreateProductCustomizationTypes < ActiveRecord::Migration
  def self.up
    create_table :product_customization_types do |t|
      t.string :name
      t.string :presentation
      t.string :description
      t.timestamps
    end

    create_table :product_customization_types_products, :id => false do |t|
      t.integer :product_customization_type_id
      t.integer :product_id
    end

  end

  def self.down
    drop_table :product_customization_types_products
    drop_table :product_customization_types
  end
end
