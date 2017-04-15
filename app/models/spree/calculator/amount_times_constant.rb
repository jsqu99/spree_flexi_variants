module Spree
  class Calculator::AmountTimesConstant < Calculator
    preference :multiplier, :decimal

    preference :min_amount, :integer, :default=>0
    preference :max_amount, :integer, :default=>100

    #attr_accessible :preferred_multiplier, :preferred_min_amount, :preferred_max_amount

    def self.description
      "Amount Times Constant Calculator"
    end

    def self.register
      super
      ProductCustomizationType.register_calculator(self)
    end

    def create_options
      # This calculator knows that it needs one CustomizableOption named amount
      [
       CustomizableProductOption.create(:name=>"amount", :presentation=>"Amount")
      ]
    end

    def compute(product_customization, variant=nil)
      return 0 unless valid_configuration? product_customization

      # expecting only one CustomizedProductOption
      opt = product_customization.customized_product_options.detect {|cpo| cpo.customizable_product_option.name == "amount" } rescue 0.0
      opt.value.to_i * preferred_multiplier
    end

    def valid_configuration?(product_customization)
      true
    end
  end
end
