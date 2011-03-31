class CreateCustomizedProductOptions < ActiveRecord::Migration
  def self.up
    create_table "customized_product_options" do |t|
      t.integer :product_customization_id
      t.integer :customizable_product_option_id
      t.string :value
      t.timestamps
    end
  end

  def self.down
    drop_table "customized_product_options"
  end
end
