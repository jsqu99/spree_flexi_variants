require File.dirname(__FILE__) + '/../spec_helper'

describe AdHocOptionType do

  let(:order) { Factory(:order_with_totals) }  # has a line_item attached
  let(:product) { Factory(:product) }
  let(:ad_hoc_option_values) {               # a list of two ad_hoc_option_values
    [
      Factory(:ad_hoc_option_value),
      Factory(:ad_hoc_option_value)
    ]
  }

  context "#create an ad hoc option type with a 'dependent' price_modifier_type" do
    # it "
  end
end # add customizable product
