class CreateProductOptionValues < ActiveRecord::Migration
  def self.up
    create_table :product_option_values do |t|
      t.integer  "product_id"
      t.integer  "option_value_id"
      t.decimal :price_modifier, :null => true, :default => nil, :precision => 8, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :product_option_values
  end
end
