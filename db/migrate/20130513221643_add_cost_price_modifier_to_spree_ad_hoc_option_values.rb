class AddCostPriceModifierToSpreeAdHocOptionValues < ActiveRecord::Migration
  def change
    add_column :spree_ad_hoc_option_values, :cost_price_modifier, :decimarl, :precision => 8, :scale => 2
  end
end
