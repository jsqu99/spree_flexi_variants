require 'spec_helper'

describe OptionType do
  it "foo" do
    option_type= FactoryGirl.create(:option_type)

    configuration = FactoryGirl.create(:pricing_configurable => option_type, :amount_option_pricing_configuration)

    ovas=[]
    3.times do |x|
      ovas << FactoryGirl.create(:option_value_amount, :amount_option_pricing_configuration => configuration, :option_value => Factory(:option_value, :option_type => :option_type)))
    end

    ova = ovas.last
    option_type.option_pricing_configuration.compute(ova.option_value).should == ova.amount
  end
end
