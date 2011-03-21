class CreateCustomizationTypes < ActiveRecord::Migration
  def self.up
    create_table :customization_types do |t|
      t.string :type
      t.integer :customization_values_types_join_id
      t.timestamps
    end
  end

  def self.down
    drop_table :customization_types
  end
end
