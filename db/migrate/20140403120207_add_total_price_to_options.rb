class AddTotalPriceToOptions < ActiveRecord::Migration
  def change
    add_column :spree_option_values, :total_price, :decimal, :precision => 8, :scale => 2
  end
end
