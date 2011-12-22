class CreateOptionPricingStrategy < ActiveRecord::Migration
  def change
    create_table :option_pricing_strategies do |t|
      t.string :type  # amount, dependent
      t.integer :pricing_strategy_id    # option_type_id, product_option_type_id
      t.string :pricing_strategy_type   # option_type, product_option_type

      t.timestamps
    end
  end
end
