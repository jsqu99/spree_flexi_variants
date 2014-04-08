require 'spec_helper'

describe Spree::OrderPopulator do

  describe 'validation' do

    let(:order) { double('Order') }
    subject { Spree::OrderPopulator.new(order, 'USD') }
    let(:variant) { double('Variant', :name => 'T-Shirt', :options_text => 'Size: M') }

    before do
      shipcat_default = Spree::ShippingCategory.create!(:name => 'Default Shipping')
      tax_cat = Spree::TaxCategory.create!({name: 'Default Tax', description: 'Kitchen-Services', is_default: true})

      Spree::Variant.stub(:find).and_return(variant)
      order.should_receive(:contents).at_least(:once).and_return(Spree::OrderContents.new(self))

      opt_devices = Spree::OptionType.create!({name: 'devices', presentation: 'Kitchen Devices', position: 1})
      opt_devices_values = []
      opt_devices_values << Spree::OptionValue.create!({option_type: opt_devices, presentation: 'Device Set Small', name: 'device-set-small1', position: 1, total_price: 750})
      @product = Spree::Product.create!(name: 'Kitchen', price: 900, tax_category: tax_cat, shipping_category: shipcat_default, description: '', available_on: Time.zone.now)


      adhoc_opt_type = Spree::AdHocOptionType.create!(product: @product, option_type: opt_devices, position: 1, is_required: true)
      opt_devices_values.each_with_index do |opt_val, val_idx|
        Spree::AdHocOptionValue.create!(ad_hoc_option_type: adhoc_opt_type, option_value: opt_val, selected: val_idx == 0)
      end
    end

    it 'should invalidate if no value of required option_type given' do
      shipment = nil
      ad_hoc_option_value_ids = nil
      product_customizations = nil
      order.contents.should_receive(:add).with(variant, 1, subject.currency, shipment, ad_hoc_option_value_ids, product_customizations).and_return double.as_null_object
      valid = subject.populate(:products => { @product.to_param => variant.to_param }, :quantity => 1, ad_hoc_option_value_ids: ad_hoc_option_value_ids, product_customizations: product_customizations)
      # TODO enhance this test so that it tests what it is ought to
      # - create a real order
      # assert valid == false, 'invalid order populated'
    end
  end
end