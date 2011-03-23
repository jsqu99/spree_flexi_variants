class CreateCustomizationTypes < ActiveRecord::Migration
  def self.up
    create_table :customization_types do |t|
      t.integer :customization_values_types_join_id
      t.string :name
      t.string :presentation
      t.timestamps
    end

    create_table :customization_types_products, :id => false do |t|
      t.integer :customization_type_id
      t.integer :product_id
    end

  end

  def self.down
    drop_table :customization_types_products
    drop_table :customization_types
  end
end
