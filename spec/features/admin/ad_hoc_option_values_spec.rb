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
      red_value = color_option_type.option_values.create!(name: 'red', presentation: 'Red', total_price: 100.0)
      green_value = color_option_type.option_values.create!(name: 'green', presentation: 'Green', total_price: 200.0)
      blue_value = color_option_type.option_values.create!(name: 'blue', presentation: 'Blue', total_price: 300.0)
      color_ad_hoc_option_type = Spree::AdHocOptionType.create!(option_type_id: color_option_type.id, product_id: test_product.id)
      color_ad_hoc_option_type.ad_hoc_option_values.create!(option_value_id: red_value.id)
      color_ad_hoc_option_type.ad_hoc_option_values.create!(option_value_id: blue_value.id)
      color_ad_hoc_option_type.ad_hoc_option_values.create!(option_value_id: green_value.id)
    end

    def goto_ad_hoc_option_value_edit
      visit '/admin'
      click_on 'Products'
      click_on 'Test Product'
      click_on 'Ad Hoc Option Types'
      first("[data-action='edit']").click
    end

    def goto_option_type_edit
      visit '/admin'
      click_on 'Products'
      click_on 'Option Types'
      first("[data-action='edit']").click
    end

    it 'removes the associated option value when clicked' do
      goto_ad_hoc_option_value_edit

      expect(page).to have_content('Editing Option Type')
      expect(all('#option_values tr').length).to eq(3)

      first("[data-method='delete']").click
      expect(page).to_not have_content('No route matches')

      goto_ad_hoc_option_value_edit
      expect(all('#option_values tr').length).to eq(2)
    end

    it 'ad hoc option value uses option value total price by default' do
      goto_ad_hoc_option_value_edit

      first('.price_modifier>input').value.should eq('100.0')
    end

    it 'ad hoc option value provides attachment file field' do
      goto_option_type_edit

      expect(all("input[type='file']").length).to eq(3)
    end

    it 'ad hoc option value provides description field' do
      goto_option_type_edit

      expect(all('.description').length).to eq(3)
    end
  end
end
