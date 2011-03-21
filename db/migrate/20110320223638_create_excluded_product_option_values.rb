class CreateExcludedProductOptionValues < ActiveRecord::Migration
  def self.up
    create_table "excluded_product_option_values" do |t|
      t.integer :configuration_exclusion_id
      t.integer :product_option_value_id
    end

  end

  def self.down
    drop_table "excluded_product_option_values"
  end
end
