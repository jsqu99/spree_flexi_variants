class AddAttachmentToOptionValues < ActiveRecord::Migration
  def self.up
    add_attachment :spree_option_values, :attachment
  end

  def self.down
    remove_attachment :spree_option_values, :attachment
  end
end
