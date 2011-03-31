class CreateProductCustomizations < ActiveRecord::Migration
  def self.up
    create_table :product_customizations do |t|
      t.integer :line_item_id
      t.integer :product_customization_type_id
      t.timestamps
    end
  end

  def self.down
    drop_table :product_customizations
  end
end
