require File.dirname(__FILE__) + '/../spec_helper'

describe Order do

  let(:order) { Factory(:order2) }
  let(:product) { Factory(:product) }

  context "#add ad hoc product" do
    before do

      # TODO: so I KNOW this is some ugly-ass shit that needs to moved into the
      # factories...I'm working on my mad rspec/factory_girl skillz...so bear with me
      option_types=[]
      @ahovs=[]

      # create at least two option types
      (rand(4)+2).times { option_types << Factory(:option_type_with_multiple_values) }

      # create one ad hoc option type for each option type
      option_types.each do |ot|
        ahot = Factory(:ad_hoc_option_type, :product => product, :option_type => ot)

        # create the n ad hoc option values that correspond to the n option_values in the ot
        ot.option_values.each do |ov|
          @ahovs << Factory(:ad_hoc_option_value, :ad_hoc_option_type => ahot, :option_value => ov)
        end
      end

      @ov_ids = @ahovs.map(&:id).map(&:to_s)
    end

    context "with new configuration" do
      it "should return new line item" do
        orig_items = order.line_items
        new_items = orig_items.clone
        li= order.add_variant(product.master, @ov_ids, [], 1) # the [] is the guaranteed non-nil customizations.  See module ProductCustomizations for more info
        li.should_not be_nil
        new_items.include?(li).should be_false
      end
    end

    context "with existing configuration" do
      let(:existing_line_item) { Factory.build(:line_item, :order=>order, :variant => product.master) }

      before do
        @ahovs.each do |a|
          existing_line_item.ad_hoc_option_values << a
        end
        existing_line_item.product_customizations=[]
        existing_line_item.save
      end

      it "should return existing line item with quantity incremented" do
        orig_qty = existing_line_item.quantity
        li= order.add_variant(product.master, @ov_ids, [], 1) # the [] is the guaranteed non-nil customizations.  See module ProductCustomizations for more info

        li.id.should == existing_line_item.id
        li.quantity.should == orig_qty+1
      end
    end
  end

  context "#add customizable product" do
    let(:calculator) { Calculator::ProductArea.new }

    before do
      calculator.stub :preferred_min_width => 4
      calculator.stub :preferred_max_width => 40
      calculator.stub :preferred_min_height => 5
      calculator.stub :preferred_max_height => 50
      calculator.stub :preferred_min_pricing_area => 20
      calculator.stub :preferred_multiplier => 3

      # TODO: so I KNOW this is some ugly-ass shit that needs to moved into the
      # factories...I'm working on my mad rspec/factory_girl skillz...so bear with me

      @cust_type = Factory(:product_customization_type, :calculator => calculator, :products => [product])
      @height_opt_type = Factory(:customizable_product_option, :name => 'height', :product_customization_type => @cust_type,:data_validation => ({:type => :decimal, :required => true}).to_json)
      @width_opt_type = Factory(:customizable_product_option, :name => 'width',  :product_customization_type => @cust_type,:data_validation => ({:type => :decimal, :required => true}).to_json)

      @customization = Factory(:product_customization, :product_customization_type => @cust_type)
      @height_cust =  Factory(:customized_product_option, :value => 10, :product_customization => @customization, :customizable_product_option => @height_opt_type)
      @width_cust = Factory(:customized_product_option,   :value => 10, :product_customization => @customization, :customizable_product_option => @width_opt_type)
    end

    context "with new configuration" do
      it "should return new line item" do
        orig_items = order.line_items
        new_items = orig_items.clone
        li= order.add_variant(product.master, [], [@customization], 1)
        li.should_not be_nil
        new_items.include?(li).should be_false
      end
    end

    context "with existing configuration" do

      before do
        @existing_line_item = Factory(:line_item, :order=>order, :variant => product.master)
        # let's add the 'same' configuration down below (without the foreign key attached)
        @new_customization = @customization.clone
        @new_height_cust = @height_cust.clone
        @new_height_cust.product_customization = @new_customization
        @new_width_cust = @height_cust.clone
        @new_width_cust.product_customization = @new_customization

        @new_customization.save
        @new_customization.customized_product_options = [@new_width_cust, @new_height_cust] # need this for the 'compute' function
        @customization.line_item = @existing_line_item
      end

      it "should return existing line item" do
        orig_qty = @existing_line_item.quantity
        li= order.add_variant(product.master, [], [@new_customization], 1)
        li.id.should == @existing_line_item.id
        li.quantity.should == orig_qty+1
      end
    end
  end # context
end # add customizable product
