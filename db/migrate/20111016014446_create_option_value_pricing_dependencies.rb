class CreateOptionValuePricingDependencies < ActiveRecord::Migration
  def change
    create_table :option_value_pricing_dependencies do |t|

      t.integer :dependent_option_value_id
      t.integer :independent_option_value_id

      t.timestamps
    end
  end

end
