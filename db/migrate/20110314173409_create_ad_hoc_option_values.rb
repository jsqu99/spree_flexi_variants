class CreateAdHocOptionValues < ActiveRecord::Migration
  def self.up
    create_table :ad_hoc_option_values do |t|
      t.integer  "ad_hoc_option_type_id"
      t.integer  "option_value_id"
      t.decimal "price_modifier", :null => false, :default => 0, :precision => 8, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :ad_hoc_option_values
  end
end
