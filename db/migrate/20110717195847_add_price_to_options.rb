class AddPriceToOptions < ActiveRecord::Migration
  def self.up
    add_column :option_values, :price, :decimal, :precision => 8, :scale => 2, :default => 0.0, :null => false
  end

  def self.down
    remove_column :option_values
  end
end
