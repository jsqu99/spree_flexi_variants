class AddDescriptionColumnToOptionValues < ActiveRecord::Migration
  def change
    add_column :spree_option_values, :description, :text, default: ''
  end
end
