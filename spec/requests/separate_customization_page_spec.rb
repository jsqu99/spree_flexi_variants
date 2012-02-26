require 'spec_helper'

describe "Products Page" do

  let(:product) { Factory(:product_with_engraving) }


  describe "#GET /product/my_engraveable_product" do
    describe "#separate customization page configured" do

      it "#displays the product with no cart form, and a link to customize" do

        SpreeFlexiVariants::Config.set :use_separate_customizations_page => true

        visit product_path(product)

        page.should have_no_selector('#cart-form form')
        page.should have_content('Customize') # how do you account for locales in tests? e.g. t('Customize')
      end
    end

    describe "#customize product on main page configured" do
      it "#displays the product with cart form with customizations" do

        SpreeFlexiVariants::Config.set :use_separate_customizations_page => false

        visit product_path(product)

        page.should have_selector('#cart-form form')
        page.should have_no_content('Customize')
      end
    end
  end
end
