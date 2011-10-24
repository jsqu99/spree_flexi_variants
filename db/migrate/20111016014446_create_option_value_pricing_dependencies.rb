class CreateOptionValuePricingDependencies < ActiveRecord::Migration
  def change
    create_table :option_value_pricing_dependencies do |t|

      t.integer :dependent_option_pricing_configuration_id, :null => false

      # points to either option_value or product_option_value
      t.string :dependent_option_value_locatable_type
      t.integer :dependent_option_value_locatable_id

      # points to either option_value or product_option_value
      t.string :independent_option_value_locatable_type
      t.integer :independent_option_value_locatable_id

      # might want enhance this to reference another table that handles things like percentage, etc.
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0.0, :null => false

      t.timestamps
    end
  end

end
