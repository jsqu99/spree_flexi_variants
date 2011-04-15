class CreateAdHocOptionValuesLineItems < ActiveRecord::Migration
  def self.up
    create_table :ad_hoc_option_values_line_items, :id=>false do |t|
      t.integer :line_item_id
      t.integer :ad_hoc_option_value_id
      t.timestamps
    end
  end

  def self.down
    drop_table :ad_hoc_option_values_line_items
  end
end
