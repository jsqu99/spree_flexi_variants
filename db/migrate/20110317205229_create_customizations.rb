class CreateCustomizations < ActiveRecord::Migration
  def self.up
    create_table :customizations do |t|
      t.integer :line_item_id
      t.integer :customization_type_id
      t.timestamps
    end
  end

  def self.down
    drop_table :customizations
  end
end
