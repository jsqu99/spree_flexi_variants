require_dependency 'spree/calculator'

module Spree
  class Calculator::Engraving < Calculator
    preference :price_per_letter, :decimal
    #attr_accessible :preferred_price_per_letter

    def self.description
      "Engraving Calculator"
    end

    def self.register
      super
      ProductCustomizationType.register_calculator(self)
    end

    def create_options
      # This calculator knows that it needs one CustomizableOption named inscription
      [
       CustomizableProductOption.create(:name=>"inscription", :presentation=>"Inscription")
      ]
    end

    def compute(product_customization, variant=nil)
      return 0 unless valid_configuration? product_customization

      # expecting only one CustomizedProductOption
      opt = product_customization.customized_product_options.detect {|cpo| cpo.customizable_product_option.name == "inscription" } rescue ''
      opt.value.length * (preferred_price_per_letter || 0)
    end

    def valid_configuration?(product_customization)
      true
    end
  end
end
