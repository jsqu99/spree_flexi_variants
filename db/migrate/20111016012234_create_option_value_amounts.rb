class CreateOptionValueAmounts < ActiveRecord::Migration
  def change
    create_table :option_value_amounts do |t|
      t.integer :amount_option_pricing_configuration_id, :null => false
      t.integer :option_value_id, :null => false
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0.0, :null => false

      t.timestamps
    end
  end
end
