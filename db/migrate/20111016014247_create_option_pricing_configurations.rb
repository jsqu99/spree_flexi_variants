class CreateOptionPricingConfigurations < ActiveRecord::Migration
  def change
    create_table :option_pricing_configurations do |t|
      t.string :type
      t.integer :pricing_configurable_id
      t.string :pricing_configurable_type

      t.timestamps
    end
  end
end
