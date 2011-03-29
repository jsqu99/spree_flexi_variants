# -*- coding: utf-8 -*-
ProductsController.class_eval do
  helper do 
    def on_demand_option_value_options(product_option_values)
      options = product_option_values.map do |pov| 
        
        plus_or_minus=""

        if pov.price_modifier>0
          plus_or_minus ="+"
        elsif pov.price_modifier<0
          plus_or_minus ="" # the minus is built into the value
        end
                         
        [(pov.price_modifier.nil? ? pov.option_value.presentation : "#{pov.option_value.presentation} (#{plus_or_minus}#{number_to_currency pov.price_modifier})"), pov.id.to_s]
      end
    end

#    def variant_filters(product)
#      product.configuration_exclusions.each do |ce|
#        # each one of these is a group of option values that should need be allowed together
#   
#        exclusion_group_map = Hash.new([])  # key will be pot.id, value will be list of pov.ids
#  
#        ce.excluded_product_option_values do |epov|
#          # shortcuts
#          pot= epov.product_option_value.product_option_type
#          
#          # now grab every other epov and filter on these, for this epov
#          exclusion_group_map[pot.id] << (ce.excluded_product_option_values - epov).map |e| do
#            e.pov.id
#          end
#        end
#      end
#
#      str=""
#
#      exclusion_group_map.each_pair do |pot, povs|
#        povs.each do |pov|
#          str+= "$('product_option_values_#{pot.id}').filterOn('#product_option_values_#{pov.pot.id}'), {"
#
#          str+="   '#{pov.id}:   []
##          $('#theOptions').filterOn('#length', {
##            '1': ['1','2','3'],
##            '2': ['a','b','c']        
##          });
#        end
#    end # variant_filters
#  end # helper

#    def exclusions
#      # return an array of illegal option_values, given the input form data
#      exclusions=[]
#      
#      params[:products].each do |pid|
#        p=Product.find(pid)
#        if ! p.configuration_exclusions.empty?
#          p.configuration_exclusions.excluded_product_option_values.map(&:product_option_value)
#        end
#      end if params[:products]
#
#      params[:product_option_values].each do |pov|
#        pov.
#      end if params[:product_option_values]
    end
end
