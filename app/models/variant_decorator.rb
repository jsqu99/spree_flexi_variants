Variant.class_eval do
  def self.find_or_create_by_option_values(master_variant_id, option_values)
debugger
    ovids=option_values.map(&:id).flatten

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
    
    # do we need to create 
    if results.size>0
      return Variant.find(results[0][0])
    else
      # need to create a variant, then a bunch of option_values_variants
      variant= Variant.create(:product_id => Variant.find(master_variant_id).product.id, :is_master => false) # TODO :price

      option_values.each do |ov|
        variant.option_values << OptionValue.find(ov.id)
      end
      variant.save # TODO: necessary? or does the << above write to the db?
      variant
    end
  end
end
