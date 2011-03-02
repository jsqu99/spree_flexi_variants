class AddPriceModifierTypeToProductOptionTypes < ActiveRecord::Migration
  def self.up
    add_column :product_option_types, :price_modifier_type, :string, :null => true, :default => nil
  end

  def self.down
    remove_column :product_option_types, :price_modifier_type
  end
end
