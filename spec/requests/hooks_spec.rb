# make sure our hooks are loaded correctly
require 'spec_helper'

describe ProductsController do

  describe "GET /product/my_product" do
    before(:each) do
      @product = Factory(:product)
      # avoid capybara 'feature' http://www.ruby-forum.com/topic/216322
      # visit product_path(@product)
      get product_path(@product)
    end

    it "loads the appropriate extension partials" do
      response.should render_template(:partial => '_content_for_head')
      response.should render_template(:partial => '_ad_hoc_option_types')
      response.should render_template(:partial => '_customizations')
      response.should render_template(:partial => '_pricing')
    end
  end
end
