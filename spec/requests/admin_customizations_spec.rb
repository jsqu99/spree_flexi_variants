require 'spec_helper'

describe "Administration of Customizations" do

  # I'm using capybara, and I need some DB records to exist across 'visit' calls, so I did this in the helper:

  # config.use_transactional_fixtures = false

  # I want finer grained control over the truncation of the DB (so I dont' affect 'all' or 'none' of the tests).
  # That's why I put these DBcleaner calls here.

  # I'm not going to lie.  I got confused as hell during this whole process, and below is the only way
  # I could get everything to work.  If you have any recommendations, feel free to send them my way


  let(:product) { Factory(:product) }
  #  let(:customization) {Factory(:engraving_customization_type)

  before(:all) do

    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
    DatabaseCleaner.clean  # ensure start w/ a clean DB

    Factory(:admin_user, :email => 'spree2@example.com', :password => "spree123", :password_confirmation => "spree123")

  end

  before(:each) do
    visit new_user_session_path

    fill_in "Email", :with => "spree2@example.com"
    fill_in "Password", :with => "spree123"
    click_button "Log In"
  end

  after(:all) do
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
    end
  end

  context "#product edit" do

    it "allows customizations to be listed, attached, and detached" ,:js => true do
      visit edit_admin_product_path(product.permalink)

      # unfortunately, there are two links named Customization Types
      # click_link "Customization Types"
      page.find("#sidebar a", :text => "Customization Types").click

      # show available customization types
      page.find("#new_ct_link a").click

      # select a customization type
      page.find("#customization-types a.iconlink").click

      # remove
      page.find("#selected-customization-types td.actions a").click
      page.should have_content "Product Customization Type Removed"
    end
  end
end

