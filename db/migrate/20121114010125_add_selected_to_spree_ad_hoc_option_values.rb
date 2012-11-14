class AddSelectedToSpreeAdHocOptionValues < ActiveRecord::Migration
  def change
    add_column :spree_ad_hoc_option_values, :selected, :boolean
  end
end
