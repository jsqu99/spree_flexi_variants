class AddPriceModifiersToOptionValues < ActiveRecord::Migration
  def self.up
    add_column :product_option_types, :price_modifier_type, :string, :null => true, :default => nil
    add_column :option_values, :price_modifier, :decimal, :null => true, :default => nil, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :product_option_types, :price_modifier_type
    remove_column :option_values, :price_modifier
  end
end
