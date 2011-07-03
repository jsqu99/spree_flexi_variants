require 'spec_helper'

describe "Administration of Customizations" do

  # I'm using capybara, and I need some DB records to exist across 'visit' calls, so I did this in the helper:

  # config.use_transactional_fixtures = false

  # I want finer grained control over the truncation of the DB (so I dont' affect 'all' or 'none' of the tests.
  # That's why I put these DBcleaner calls here.

  # I'm not going to lie.  I got confused as hell during this whole process, and below is the only way
  # I could get everything to work.  If you have any recommendations, feel free to send them my way

  before(:all) do
    DatabaseCleaner.strategy = :truncation
  end

  before(:each) do
    DatabaseCleaner.start
    DatabaseCleaner.clean  # ensure start w/ a clean DB

    Factory(:admin_user, :email => 'spree2@example.com', :password => "spree123", :password_confirmation => "spree123")

    visit new_user_session_path

    fill_in "Email", :with => "spree2@example.com"
    fill_in "Password", :with => "spree123"
    click_button "Log In"
  end

  after(:each) do
    DatabaseCleaner.clean
  end


  context "#creating customization types" do
    it "allows creation of a new customization type" do
      visit admin_product_customization_types_path

      # create and save
      click_link "new_product_customization_type_link"
      fill_in "Name", :with => "fancy_customization"
      fill_in "Presentation", :with => "Fancy Customzation"
      page.select "Engraving Calculator", :from => "calc-type"
      page.find('.new_product_customization_type button[type=submit]').click

      # configure calculator
      fill_in "product_customization_type_calculator_attributes_preferred_price_per_letter", :with => "10"
      page.find('#product_customization_type_customizable_product_options_attributes_0_presentation').value.should == "Inscription"

      # update and go back to listings
      page.find('.form-buttons button[type=submit]').click
      page.should have_content "successfully updated"
      save_and_open_page

    end
  end

  context "#attaching customization types to products" do
    #let(:product) { Factory(:product_with_engraving) }

    before(:each) do
      @product = Factory(:product)
      @customization = Factory(:engraving_customization_type)

      page.driver.header 'Accept', 'text/javascript' # these calls below are supposed to render js
    end

    it "shows a listing of available customiztions" do
      visit available_admin_product_product_customization_types_path(@product)
      pending "need to learn how to follow the JS and detect HTML elements"
    end

    it "allows a customization type to be attached to a product" do
      visit select_admin_product_product_customization_type_path(@product, @customization)
      pending "need to learn how to follow the JS and detect HTML elements"
    end
  end
end

