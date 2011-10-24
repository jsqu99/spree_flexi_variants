require 'spec_helper'

describe OptionType do
  context "amount_option_pricing_configuration" do
    it "correctly computes price for an option value" do
      option_type= FactoryGirl.create(:option_type)

      configuration = FactoryGirl.create(:amount_option_pricing_configuration, :pricing_configurable => option_type)

      ova=FactoryGirl.create(:option_value_amount, :amount_option_pricing_configuration => configuration, :option_value => FactoryGirl.create(:option_value, :option_type => option_type))

      option_type.option_pricing_configuration.compute(nil,ova.option_value).should == ova.amount
    end
  end
end
