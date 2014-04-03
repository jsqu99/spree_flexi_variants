require 'spec_helper'

describe 'Ad Hoc Option Values', js: true do
  describe 'remove links' do
    extend Spree::TestingSupport::AuthorizationHelpers::Request
    stub_authorization!

    before do
      if defined? Spree::Dash
        # stub out jirafe so it doesn't choke on the register call
        Spree::Dash::Config.app_id = nil
        Spree::Dash::Config.app_token = nil
        Spree::Dash::Config.site_id = nil
        Spree::Dash::Config.token = nil

        Spree::Dash::Jirafe.should_receive(:register).
                          and_return({ :app_id => '1', :app_token => '2', :site_id => '3', :site_token => '4' })
      end

      ship_cat = Spree::ShippingCategory.create!(name: 'Standard')

      test_product = Spree::Product.create!(name: 'Test Product', price: 12.99, shipping_category: ship_cat)
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
      first("[data-action='edit']").click

      expect(page).to have_content('Editing Option Type')
      expect(all('#option_values tr').length).to eq(3)

      first("[data-method='delete']").click
      expect(page).to_not have_content('No route matches')

      visit '/admin'
      click_on 'Products'
      click_on 'Test Product'
      click_on 'Ad Hoc Option Types'
      first("[data-action='edit']").click
      expect(all('#option_values tr').length).to eq(2)
    end
  end
end
