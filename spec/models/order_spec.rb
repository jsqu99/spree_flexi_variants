require File.dirname(__FILE__) + '/../spec_helper'

describe Order do

  let(:order) { Factory(:order_with_totals) }  # has a line_item attached
  let(:product) { Factory(:product) }
  let(:ad_hoc_option_values) {               # a list of two ad_hoc_option_values
    [
      Factory(:ad_hoc_option_value),
      Factory(:ad_hoc_option_value)
    ]
  }

  context "#add product with ad hoc options selected" do

    before do
      @ov_ids = ad_hoc_option_values.map(&:id).map(&:to_s)
    end

    context "with a new option combination" do
      it "returns a new line item" do
        orig_items = order.line_items.clone

        li= order.add_variant(product.master, @ov_ids, [], 1)
        li.should_not be_nil
        orig_items.include?(li).should be_false
      end
    end

    context "with an option combination identical to that of one already added to cart" do
      it "returns the existing line item with the quantity incremented" do
        orig_li = order.line_items[0]
        orig_li.variant_id = product.master.id # ensure we are attempting to add the same variant
        orig_li.ad_hoc_option_values = ad_hoc_option_values

        orig_qty = orig_li.quantity
        li= order.add_variant(product.master, @ov_ids, [], 1)

        li.id.should ==  order.line_items[0].id
        li.quantity.should == orig_qty+1
      end
    end
  end

  context "#add a product having a customization" do

    let (:customization) { Factory(:engraving_customization) }

    context "with a unique customization" do
      it "returns a new line item" do
        orig_items = order.line_items.clone

        li= order.add_variant(product.master, [], [customization], 1)
        li.should_not be_nil
        orig_items.include?(li).should be_false
      end
    end

    context "with a customization identical to that of one already added to cart" do
      it "returns existing line item" do
        orig_li = order.line_items[0]
        orig_li.variant_id = product.master.id # ensure we are attempting to add the same variant
        orig_li.product_customizations = [customization]

        orig_qty = order.line_items[0].quantity

        li= order.add_variant(product.master, [], [customization], 1)
        li.id.should == order.line_items[0].id
        li.quantity.should == orig_qty+1
      end
    end # context
  end # context
end # add customizable product
