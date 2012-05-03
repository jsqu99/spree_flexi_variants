class AddPriceAffectingOptionTypeToOptionTypes < ActiveRecord::Migration
  def change
    add_column :spree_ad_hoc_option_types, :price_affecting_option_type_id, :integer
  end
end
