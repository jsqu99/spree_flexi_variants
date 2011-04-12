class CreateCustomizableProductOptions < ActiveRecord::Migration
  def self.up
    create_table "customizable_product_options" do |t|
      t.integer  :product_customization_type_id
      t.integer  :position
      t.string   :presentation,       :null => false
      t.string   :name,        :null => false
      t.string   :description
      t.string   :data_type, :default => "string"
      t.boolean  :is_required, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table "customizable_product_options"
  end
end
