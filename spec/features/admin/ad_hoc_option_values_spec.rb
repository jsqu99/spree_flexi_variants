require 'spec_helper'

describe 'Ad Hoc Option Values', js: true do
  describe 'remove links' do
    extend AuthorizationHelpers::Request
    stub_authorization!

    before do
      test_product = Spree::Product.create!(name: 'Test Product', price: 12.99)
      color_option_type = Spree::OptionType.create!(name: 'color', presentation: 'Color')
      red_value = color_option_type.option_values.create!(name: 'red', presentation: 'Red')
      green_value = color_option_type.option_values.create!(name: 'green', presentation: 'Green')
      blue_value = color_option_type.option_values.create!(name: 'blue', presentation: 'Blue')
      color_ad_hoc_option_type = Spree::AdHocOptionType.create!(option_type_id: color_option_type.id, product_id: test_product.id)
      color_ad_hoc_option_type.ad_hoc_option_values.create!(option_value_id: red_value.id)
      color_ad_hoc_option_type.ad_hoc_option_values.create!(option_value_id: blue_value.id)
      color_ad_hoc_option_type.ad_hoc_option_values.create!(option_value_id: green_value.id)
    end

    it 'removes the associated option value when clicked' do
      visit '/admin'
      click_on 'Products'
      click_on 'Test Product'
      click_on 'Ad Hoc Option Types'
      click_on 'Edit'

      expect(page).to have_content('Editing Option Type')
      expect(all('#option_values tr').length).to eq(4)

      first(:link, 'Remove').click
      expect(page).to_not have_content('No route matches')

      visit '/admin'
      click_on 'Products'
      click_on 'Test Product'
      click_on 'Ad Hoc Option Types'
      click_on 'Edit'
      expect(all('#option_values tr').length).to eq(3)
    end
  end
end
