class Calculator::AmountTimesConstant < Calculator
  preference :multiplier, :decimal

  preference :min_amount, :integer, :default=>0
  preference :max_amount, :integer, :default=>100

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
     CustomizableProductOption.create(:name=>"amount", :presentation=>"Amount" ,
                                      :data_validation=>(
                                                         {:type => :decimal, :min => :min_amount, :max => :max_amount,
                                                           :required => false}).to_json
                                      )
    ]
  end

  def compute(product_customization)
    return 0 unless valid_configuration? product_customization

    # expecting only one CustomizedProductOption
    opt = product_customization.customized_product_options.detect {|cpo| cpo.customizable_product_option.name == "amount" } rescue 0.0
    opt.value.to_i * preferred_multiplier
  end

  def valid_configuration?(product_customization)
    true
  end
end
