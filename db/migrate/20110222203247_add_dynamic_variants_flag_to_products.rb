class AddDynamicVariantsFlagToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :has_on_demand_variants, :boolean, :default => false
  end

  def self.down
    remove_column :products, :has_on_demand_variants
  end
end
