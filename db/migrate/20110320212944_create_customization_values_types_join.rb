class CreateCustomizationValuesTypesJoin < ActiveRecord::Migration
  def self.up
    create_table "customization_values_types_join", :id => false do |t|
      t.integer "customization_type_id"
      t.integer "customization_value_type_id"
    end
  end

  def self.down
    drop_table "customization_values_types_join"
  end
end
