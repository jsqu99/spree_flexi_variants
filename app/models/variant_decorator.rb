Variant.class_eval do
  
#  has_many :customization_values ????

  def self.find_or_create_by_option_values(ov_configs)

    # TODO are these 'flattens' below necessary?  
    product          = ov_configs.first.product_option_type.product
    option_values    = ov_configs.map(&:option_value).flatten
    ovids            = option_values.map(&:id).flatten

    cur_price = product.price + ov_configs.sum(&:price_modifier)

    sql= <<FINDSQL
      SELECT v.id 
      FROM   variants v,option_values ov, option_values_variants ovv,
        (SELECT variant_id, count(*) ovv_count
                FROM option_values_variants inner_ovv
                WHERE inner_ovv.option_value_id IN (#{ovids.join(',')}) GROUP BY variant_id) ovv_count_table
      WHERE 
             ov.id in (#{ovids.join(',')}) AND
             ovv_count_table.ovv_count = #{ovids.size} AND
             ovv_count_table.variant_id=v.id AND
             ovv.variant_id=v.id AND
             ov.id=ovv.option_value_id
FINDSQL

    results=ActiveRecord::Base.connection.select_rows sql
    
    # do we need to create a new variant?  or reuse an existing one
    if results.size>0
      # let's make sure the price doesn't need to be updated
      variant=Variant.find(results[0][0])
      if variant.price != cur_price
        variant.price = cur_price
        variant.save
      end

      return variant
    else
      # need to create a variant, then a bunch of option_values_variants
      price=option_values
      # product= Variant.find(master_variant_id).product
      variant= Variant.create(:product_id => product.id, :is_master => false, :price => cur_price) 

      option_values.each do |ov|
        variant.option_values << OptionValue.find(ov.id)
      end
      variant.save # TODO: necessary? or does the << above write to the db?
      variant
    end
  end
end
