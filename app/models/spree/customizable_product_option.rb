module Spree
  class CustomizableProductOption < ActiveRecord::Base
    belongs_to :product_customization_type
    delegate :calculator, :to => :product_customization_type
  end
end
