require 'spec_helper'

describe OptionType do
  context "amount_option_pricing_strategy" do

    let (:strategy) { FactoryGirl.create(:amount_option_pricing_strategy) }

    before do
      @option_type = strategy.pricing_strategy
      @option_value_amount = strategy.option_value_amounts.first
      @option_value = @option_value_amount.option_value
    end

    it "correctly computes price for an option value" do
      strategy.compute(nil,@option_value).should == @option_value_amount.amount
    end
  end

  context "dependent_option_pricing_strategy" do
    let (:strategy) { FactoryGirl.create(:dependent_option_pricing_strategy) }

    before do
      @option_type = strategy.pricing_strategy
      @option_value_pricing_dependency = strategy.option_value_pricing_dependencies.first
      @dependent_option_value   = @option_value_pricing_dependency.dependent_option_value
      @independent_option_value = @option_value_pricing_dependency.independent_option_value
    end

    it "correctly computes price for an option value" do
      strategy.compute(nil,@dependent_option_value).should == @option_value_amount.amount
    end

  end
end
