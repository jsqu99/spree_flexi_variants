require 'spec_helper'

describe "Customizations", :js=>true do

  before(:each) do
    @product = Factory(:product_with_engraving)
    visit product_path(@product)
  end

  describe "GET /product/my_engraveable_product" do
    it "displays the product along with the ability to customize" do
      page.should have_content(@product.product_customization_types.first.presentation)
    end
  end

  describe "Customizing a string-based customization" do
    user_input = "Sorry about yesterday"

    it "displays the user input in the line item" do
      fill_in 'Inscription', :with => user_input


      # I can't use click_button b/c I don't have an id, type, or text"
      page.find('button[type=submit].primary').click
      page.should have_content(user_input)
    end


    # TODO: figure out how to fire the keyup event in javascript
    # after filling in the Inscription
    it "#causes a price change", :js => true do
      fill_in 'Inscription', :with => user_input
#      page.find('input[type=text].customization').trigger('keyup')

      SpreeFlexiVariants::Config.set :use_javascript_pricing_updates => true

      orig_price = @product.price
      puts "prod price: #{orig_price}"

      # this part will trigger the pricing update
      expected_new_price = orig_price + (@product.product_customization_types.first.calculator.preferred_price_per_letter.to_f * user_input.size)

      # wait...hopefully I won't have to modify: Capybara.default_wait_time
      sleep(5)
      new_price = page.find('.price.selling').text
      new_price.should == "$#{expected_new_price}"
    end

  end # describe
end
