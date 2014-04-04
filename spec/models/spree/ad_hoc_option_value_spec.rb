require 'spec_helper'

describe Spree::AdHocOptionValue do

  describe 'price inheritance' do

    it 'should have option values price after save' do

      ship_cat = Spree::ShippingCategory.create!(name: 'Standard')
      test_product = Spree::Product.create!(name: 'Kitchen1', price: 1200, shipping_category: ship_cat)

      opt_color = Spree::OptionType.create!({name: 'color', presentation: 'Farbe', position: 3})
      opt_value_color_white = Spree::OptionValue.create!({option_type: opt_color, presentation: 'Weiss', name: 'white', position: 1, total_price: 50})

      adhoc_opt_type_color = Spree::AdHocOptionType.create!(product: test_product, option_type: opt_color, position: 1)
      adhoc_opt_value_white = Spree::AdHocOptionValue.create!(ad_hoc_option_type: adhoc_opt_type_color, option_value: opt_value_color_white)

      adhoc_opt_value_white.price_modifier.to_digits.should eq(opt_value_color_white.total_price.to_digits)
    end
  end
end