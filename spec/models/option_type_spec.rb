require 'spec_helper'

describe OptionType do
  context "amount_option_pricing_configuration" do

    let (:configuration) { FactoryGirl.create(:amount_option_pricing_configuration) }

    before do
      @option_type = configuration.pricing_configurable
      @option_value_amount = configuration.option_value_amounts.first
      @option_value = @option_value_amount.option_value
    end

    it "correctly computes price for an option value" do
      configuration.compute(nil,@option_value).should == @option_value_amount.amount
    end
  end

  context "dependent_option_pricing_configuration" do
    let (:configuration) { FactoryGirl.create(:dependent_option_pricing_configuration) }

    before do
      @option_type = configuration.pricing_configurable
      @option_value_pricing_dependency = configuration.option_value_pricing_dependencies.first
      @dependent_option_value   = @option_value_pricing_dependency.dependent_option_value
      @independent_option_value = @option_value_pricing_dependency.independent_option_value
    end

    it "correctly computes price for an option value" do
      configuration.compute(nil,@dependent_option_value).should == @option_value_amount.amount
    end

  end
end
