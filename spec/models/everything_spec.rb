require 'spec_helper'

describe LineItem do
  it "needs to be configurable once in the cart"
end

describe Variant do
  it "is created when unique"
  it "is reused when not unique"
  it "can determine its price"
  it "can determine its sku"
  it "handles inventory adjustments"
end

describe "A dynamic OptionType (or ProductOptionType)" do
  it "uses its pricing configuration to compute the price of each option value"
end

describe OptionType do
  it "can be configured at the OptionType level" do
    pending "do a basic config here"
  end

  context "has been added to a product" do
    it "has option values that are copied over to 'product option values'" do
      pending "now do an 'after add' config here"
    end
  end
end


describe ProductOptionType do
  context "with a plain-vanilla (non-dynamic) OptionType" do
    it "can be configured at the ProductOptionType level"
  end

  context "with an already-configured OptionType" do
    it "can be configured at the ProductOptionType level"
  end
end

describe "An OptionPricingConfiguration" do
  context "assigned to an OptionType" do
    it "retrieves the amount configured for a given OptionValue"
  end
  context "assigned to a ProductOptionType" do
    it "retrieves the amount configured for a given ProductOptionValue"
  end
end

describe OptionPricingConfiguration::AmountOptionPricingConfiguration do
  context "configuration of a product before adding to the cart" do
    it "retrieves all possible amounts for all of this option type's values in a hash e.g. {option_value_id: amount}"
  end

  context "variant creation / retrieval phase" do
    it "retrieves the amount configured for a given option value"
  end
end

describe OptionPricingConfiguration::DependentOptionPricingConfiguration do

  context "configuration of a product before adding to the cart" do
    it "retrieves all possible combinations in a dependency hash e.g. {option_value_id: {other_option_value_id : amount}}"
  end

  context "variant creation / retrieval phase" do
    it "retrieves the amount configured for a given option value" do
      pending "by taking into consideration all of the selected option values in the variant"
    end
  end

end

describe "A dynamic option value" do
end
