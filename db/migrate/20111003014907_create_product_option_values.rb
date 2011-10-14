class CreateProductOptionValues < ActiveRecord::Migration
  def change
    create_table :product_option_values do |t|
      t.integer :product_id
      t.integer :option_value_id
      t.string :type

      t.timestamps
    end
  end
end
