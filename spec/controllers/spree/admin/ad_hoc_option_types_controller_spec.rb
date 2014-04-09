require 'spec_helper'


def create_admin_user
  pw = '123456'
  login = 'test@kinova.ch'
  admin = Spree::User.new({password: pw, password_confirmation: pw, login: login, email: login})
  admin.spree_roles << Spree::Role.find_or_create_by(name: 'admin')
  # admin.skip_confirmation!
  admin.save!
  Spree::User.admin.first!
end

describe Spree::Admin::AdHocOptionTypesController do

  before do
    @routes = Spree::Core::Engine.routes
    @user = create_admin_user
    sign_in @user
  end

  describe 'delete' do

    it 'should remove ad hoc option type from product' do

      ship_cat = Spree::ShippingCategory.create!(name: 'Standard')
      test_product = Spree::Product.create!(name: 'Kitchen1', price: 1200, shipping_category: ship_cat)
      opt_color = Spree::OptionType.create!({name: 'color', presentation: 'Farbe', position: 3})
      @adhoc_type = Spree::AdHocOptionType.create!(product: test_product, option_type: opt_color, position: 1)

      Spree::AdHocOptionType.count.should eq(1)
      count_before = Spree::AdHocOptionType.count

      delete :destroy, id: @adhoc_type

      response.should redirect_to(selected_admin_product_ad_hoc_option_types_url(test_product))
      count_after = Spree::AdHocOptionType.count
      (count_after+1).should eq(count_before)
    end
  end
end