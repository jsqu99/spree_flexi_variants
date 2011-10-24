class CreateOptionPricingConfigurations < ActiveRecord::Migration
  def change
    create_table :option_pricing_configurations do |t|
      t.string :type  # amount, dependent
      t.integer :pricing_configurable_id    # option_type_id, product_option_type_id
      t.string :pricing_configurable_type   # option_type, product_option_type

      t.timestamps
    end
  end
end
