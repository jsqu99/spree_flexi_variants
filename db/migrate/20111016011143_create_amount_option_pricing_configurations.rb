class CreateAmountOptionPricingConfigurations < ActiveRecord::Migration
  def change
    create_table :amount_option_pricing_configurations do |t|
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
