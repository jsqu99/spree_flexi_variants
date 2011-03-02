class CreateProductOptionValues < ActiveRecord::Migration
  def self.up
    create_table :product_option_values do |t|
      t.references :product
      t.references :option_value
      t.decimal :price_modifier, :null => true, :default => nil, :precision => 8, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :product_option_values
  end
end
