class AddFieldsToOptionTypes < ActiveRecord::Migration
  def change
    add_column :option_types, :required, :boolean
    add_column :option_types, :allow_multiple, :boolean
    add_column :option_types, :allow_custom_text, :boolean
    add_column :option_types, :allow_custom_image, :boolean
  end
end
