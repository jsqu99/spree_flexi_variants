class AddCarrierwaveFields < ActiveRecord::Migration
  def self.up
    add_column :customized_product_options, :customization_image, :string
  end

  def self.down
    remove_column :customized_product_options, :customization_image
  end
end
