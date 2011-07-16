require 'spec_helper'

describe Admin::OrdersController do
  context '#edit' do
    it "should not cause an error" do
      response.should be_success
    end
  end
end

