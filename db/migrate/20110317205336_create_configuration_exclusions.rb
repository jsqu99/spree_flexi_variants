class CreateConfigurationExclusions < ActiveRecord::Migration
  def self.up
    create_table :configuration_exclusions do |t|
      t.integer :product_id

      t.timestamps
    end
  end

  def self.down
    drop_table :configuration_exclusions
  end
end
