require File.dirname(__FILE__) + '/../spec_helper'

describe Order do

  before :each do
    @order=Factory(:order2)
    @product=Factory(:product)
  end

  context "#add ad hoc product" do
    before do

      option_types=[]
      @ahovs=[]

      # create at least two option types
      (rand(4)+2).times { option_types << Factory(:option_type_with_multiple_values) }

      # create one ad hoc option type for each option type
      option_types.each do |ot|
        ahot = Factory(:ad_hoc_option_type, :product => @product, :option_type => ot)

        # create the n ad hoc option values that correspond to the n option_values in the ot
        ot.option_values.each do |ov|
          @ahovs << Factory(:ad_hoc_option_value, :ad_hoc_option_type => ahot, :option_value => ov)
        end
      end

      @ov_ids = @ahovs.map(&:id).map(&:to_s)
    end

    context "with new configuration" do
      it "should return new line item" do
        orig_items = @order.line_items
        new_items = orig_items.clone
        li= @order.add_variant(@product.master, @ov_ids, [], 1) # the [] is the guaranteed non-nil customizations.  See module ProductCustomizations for more info
        li.should_not be_nil
        new_items.include?(li).should be_false
      end
    end

    context "with existing configuration" do
      before do
        @existing_line_item = Factory.build(:line_item, :order=>@order, :variant => @product.master)
        @ahovs.each do |a|
          @existing_line_item.ad_hoc_option_values << a
        end
        @existing_line_item.product_customizations=[]
        @existing_line_item.save
      end

      it "should return existing line item with quantity incremented" do
        orig_qty = @existing_line_item.quantity
        li= @order.add_variant(@product.master, @ov_ids, [], 1) # the [] is the guaranteed non-nil customizations.  See module ProductCustomizations for more info

        li.id.should == @existing_line_item.id
        li.quantity.should == orig_qty+1
      end
    end
  end

  context "#add customizable product" do
    context "with new configuration" do
      it "should return new line item"
    end

    context "with existing configuration" do
      it "should return existing line item"
    end
  end

end
