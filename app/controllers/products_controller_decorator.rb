ProductsController.class_eval do
  helper do 
    def on_demand_option_value_options(product_option_values)
      options = product_option_values.map do |pov| 
        [(pov.price_modifier.nil? ? pov.option_value.presentation : "#{pov.option_value.presentation} (#{pov.price_modifier})"), pov.id.to_s]
      end
      
      options
    end
  end
end
