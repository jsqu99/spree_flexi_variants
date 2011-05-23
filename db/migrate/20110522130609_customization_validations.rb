class CustomizationValidations < ActiveRecord::Migration
  def self.new_validation_string (data_type, required)
    {:type => data_type, :required => required=="t" }.to_json
  end

  def self.up
    add_column :customizable_product_options, :data_validation, :string, :null => true
    sql = "select id, data_type, is_required from customizable_product_options"
    results = ActiveRecord::Base.connection.execute(sql)

    results.each do |res|

      json_str = new_validation_string(res['data_type'], res['is_required'])
      sql = "update customizable_product_options set data_validation = '#{json_str}' where id = #{res['id']}"
      puts sql
      ActiveRecord::Base.connection.execute(sql)
    end

    remove_column :customizable_product_options, :data_type
    remove_column :customizable_product_options, :is_required

  end

  def self.down
    add_column :customizable_product_options, :data_type, :string, :default => "string"
    add_column :customizable_product_options, :is_required, :boolean, :default => false


    sql = "select id, data_validation from customizable_product_options"
    results = ActiveRecord::Base.connection.execute(sql)

    results.each do |res|

      j=JSON.parse res['data_validation'] if res['data_validation']

      required  = j['required']? "t":"f" rescue "f"
      data_type = j['type'] rescue ""     # string by default
      id        = res['id']

      sql = "update customizable_product_options set is_required = '#{required}', data_type = '#{data_type}' where id = #{id}"
      puts sql
      ActiveRecord::Base.connection.execute(sql)
    end


    remove_column :customizable_product_options, :data_validation
  end
end
