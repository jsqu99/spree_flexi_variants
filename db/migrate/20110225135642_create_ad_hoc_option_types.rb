class CreateAdHocOptionTypes < ActiveRecord::Migration
  def self.up
    create_table :ad_hoc_option_types do |t|
      t.integer :product_id
      t.integer :option_type_id
      t.string :price_modifier_type, :null => true, :default => nil
      t.boolean :is_required, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :ad_hoc_option_types
  end
end
