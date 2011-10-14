class AddProductOptionValuesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_id, :integer
    add_column :products, :option_value_id, :integer
  end
end
