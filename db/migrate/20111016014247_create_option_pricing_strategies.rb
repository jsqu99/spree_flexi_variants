class CreateOptionPricingStrategies < ActiveRecord::Migration
  def change
    create_table :option_pricing_strategies do |t|
      t.string :type  # amount, dependent
      t.integer :option_type_reference_id    # option_type_id, product_option_type_id
      t.string :option_type_reference_type   # option_type, product_option_type

      t.timestamps
    end
  end
end
