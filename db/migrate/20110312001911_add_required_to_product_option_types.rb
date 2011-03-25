class AddRequiredToProductOptionTypes < ActiveRecord::Migration
  def self.up
    add_column :product_option_types, :is_required, :boolean, :default => false
  end

  def self.down
    remove_column :product_option_types, :is_required
  end
end
