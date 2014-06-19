module Spree
  class CustomizableProductOption < ActiveRecord::Base
    belongs_to :product_customization_type
    delegate :calculator, :to => :product_customization_type
    #attr_accessible :name, :presentation, :description, :product_customization_type_id
  end
end
