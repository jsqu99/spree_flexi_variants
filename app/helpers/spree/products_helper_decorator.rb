module Spree
  ProductsHelper.module_eval do

    require 'json'

    # help w/ formatting the validation string
    # this method will likely be removed as we move everything to the client
    def custom_html_options(option)
      h = {:style=>"float: left;", :class=>"customization #{validation_classes(option)}"}
      va = validation_attributes(option)

      h.merge! va if va
      h
    end

    private

    def validation_attributes(option)

      return unless option.data_validation

      validation_hash=Hash.new

      data_validation = JSON.parse option.data_validation

      # Note that when you have a data_validation hash such as:
      # :data_validation=>{:type => :decimal, :min => :min_width, :max => :max_width, :required => true})
      # some the key syms match up with the jquery validation names e.g. min, max.  That's why we are able
      # to use these as-is as keys in the validation_hash below

      # min, max represent the current list of available jquery validation rules that can be specified inline
      [:min, :max].each do |m|

        next unless data_validation[m.to_s]

        # need to pull the value from the calculator via the preference name provided

        val = option.calculator.send("preferred_#{data_validation[m.to_s]}")
        validation_hash[m.to_s] = val.to_s if val

      end
      validation_hash
    end

    def validation_classes(option)
      return unless option.data_validation

      validation_str=[]

      data_validation = JSON.parse option.data_validation


      # handle data type first
      validation_str << case data_validation["type"]
                        when "string" then ""
                        when "integer" then "digits" # that's what jquery.validate uses
                        when "decimal" then "number" # that's what jquery.validate uses
                        else ""
                        end if data_validation["type"]

      validation_str << "required" if data_validation["required"]
      validation_str.join(" ")
    end

    def ad_hoc_option_value_options(ad_hoc_option_values)
      ad_hoc_option_values.map do |ah_ov|
        [ad_hoc_option_value_presentation_with_price_modifier(ah_ov),ah_ov.id.to_s]
      end
    end

    def price_change_text(ah_ov)
      plus_or_minus=""

      if ah_ov.price_modifier>0
        plus_or_minus = t("add")
      elsif ah_ov.price_modifier<0
        plus_or_minus =t("subtract")
      end

      ah_ov.price_modifier == 0 ? "" : " (#{plus_or_minus} #{Spree::Money.new(ah_ov.price_modifier.abs).to_s})"
    end


    def ad_hoc_option_value_presentation_with_price_modifier(ah_ov)
      presentation_string = ah_ov.price_modifier.nil? ? 
                             ah_ov.option_value.presentation : 
                             "#{ah_ov.option_value.presentation} #{price_change_text(ah_ov)}"
    end

    def calculator_name(product_customization_type)
      product_customization_type.calculator.class.name.demodulize.underscore rescue ""
    end
  end
end
