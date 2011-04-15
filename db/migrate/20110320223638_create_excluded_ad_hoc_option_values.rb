class CreateExcludedAdHocOptionValues < ActiveRecord::Migration
  def self.up
    create_table "excluded_ad_hoc_option_values" do |t|
      t.integer :ad_hoc_variant_exclusion_id
      t.integer :ad_hoc_option_value_id
    end
  end

  def self.down
    drop_table "excluded_ad_hoc_option_values"
  end
end
