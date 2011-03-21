class CreateCustomizationValueTypes < ActiveRecord::Migration
  def self.up
    create_table "customization_value_types" do |t|
      t.integer  :customization_values_types_join_id
      t.integer  :position,     :null => true
      t.string   :label,       :null => false
      t.string   :name,        :null => false
      t.string   :description, :null => true
      t.string   :default_value
      t.string   :data_type
      t.boolean  :required,    :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table "customization_value_types"
  end
end
