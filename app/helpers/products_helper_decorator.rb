ProductsHelper.module_eval do
  include Admin::ProductCustomizationTypesHelper  # help w/ formatting thhe validation string

  def ad_hoc_option_value_options(ad_hoc_option_values)
    options = ad_hoc_option_values.map do |ah_ov|

      plus_or_minus=""

      if ah_ov.price_modifier>0
        plus_or_minus = t("add")
      elsif ah_ov.price_modifier<0
        plus_or_minus =t("subtract")
      end

      [(ah_ov.price_modifier.nil? ? ah_ov.option_value.presentation : "#{ah_ov.option_value.presentation} (#{plus_or_minus} #{format_price ah_ov.price_modifier.abs})"), ah_ov.id.to_s]
    end
  end
end
