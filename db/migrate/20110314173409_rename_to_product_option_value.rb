class RenameToProductOptionValue < ActiveRecord::Migration
  def self.up
	rename_table :product_option_type_option_values, :product_option_values
  end

  def self.down
	rename_table :product_option_values, :product_option_type_option_values
  end
end
