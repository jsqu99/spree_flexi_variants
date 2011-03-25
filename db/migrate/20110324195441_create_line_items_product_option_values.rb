class CreateLineItemsProductOptionValues < ActiveRecord::Migration
  def self.up
    create_table :line_items_product_option_values, :id=>false do |t|
      t.integer :line_item_id
      t.integer :product_option_value_id
      t.timestamps
    end
  end

  def self.down
    drop_table :line_items_product_option_values
  end
end
