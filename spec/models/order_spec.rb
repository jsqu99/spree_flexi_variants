require File.dirname(__FILE__) + '/../spec_helper'

describe Order do

  let(:order)   { Factory(:order)   }
  let(:product) { Factory(:product) }

  context "#add ad hoc product" do
    before do
      # 3 option types, each w/ 2 option values
      ov1=Factory(:option_value2)
      ov2=Factory(:option_value2, :option_type => ov1.option_type)
      ov3=Factory(:option_value2)
      ov4=Factory(:option_value2, :option_type => ov3.option_type)
      ov5=Factory(:option_value2)
      ov6=Factory(:option_value2, :option_type => ov5.option_type)

      # create the 3 ad hoc option types that correspond to the 3 option types above
      ahot1=Factory(:ad_hoc_option_type, :product => product, :option_type => ov1.option_type)
      ahot2=Factory(:ad_hoc_option_type, :product => product, :option_type => ov3.option_type)
      ahot3=Factory(:ad_hoc_option_type, :product => product, :option_type => ov5.option_type)

      # create the 6 ad hoc option values that correspond to the 6 option_values above
      @ahov1=Factory(:ad_hoc_option_value, :ad_hoc_option_type => ahot1, :option_value => ov1)
      @ahov2=Factory(:ad_hoc_option_value, :ad_hoc_option_type => ahot1, :option_value => ov2)
      @ahov3=Factory(:ad_hoc_option_value, :ad_hoc_option_type => ahot2, :option_value => ov3)
      @ahov4=Factory(:ad_hoc_option_value, :ad_hoc_option_type => ahot2, :option_value => ov4)
      @ahov5=Factory(:ad_hoc_option_value, :ad_hoc_option_type => ahot3, :option_value => ov5)
      @ahov6=Factory(:ad_hoc_option_value, :ad_hoc_option_type => ahot3, :option_value => ov6)

      @ov_ids = [@ahov1,@ahov2,@ahov3,@ahov4,@ahov5,@ahov6].map(&:id).map(&:to_s)
    end

    context "with new configuration" do
      it "should return new line item"
    end

    context "with existing configuration" do
      before do
        @existing_line_item = Factory.build(:line_item, :order=>order, :variant => product.master)
        [@ahov1,@ahov2,@ahov3,@ahov4,@ahov5,@ahov6].each do |a|
          @existing_line_item.ad_hoc_option_values << a
        end
        @existing_line_item.product_customizations=[]
        @existing_line_item.save


        puts "LI first::::::::::::#{@existing_line_item.ad_hoc_option_values.map(&:inspect)}"

      end

      it "should return existing line item with quantity incremented" do
        orig_qty = @existing_line_item.quantity
        li= order.add_variant(product.master, @ov_ids, [], 1) # the [] is the guaranteed non-nil customizations.  See module ProductCustomizations for more info

        puts "LI:::::::::::: #{li.inspect} \n and \n #{@existing_line_item.inspect}"
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
