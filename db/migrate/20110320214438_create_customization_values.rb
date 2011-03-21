class CreateCustomizationValues < ActiveRecord::Migration
  def self.up
    create_table "customization_values" do |t|
      t.integer :customization_id
      t.integer :customization_value_type_id
      t.timestamps
    end
  end

  def self.down
    drop_table "customization_values"
  end
end
