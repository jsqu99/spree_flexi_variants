module Spree
  class ProductCustomizationType < ActiveRecord::Base
    include Spree::Core::CalculatedAdjustments
    has_and_belongs_to_many :products
    has_many :customizable_product_options, :dependent => :destroy
    accepts_nested_attributes_for :customizable_product_options, :allow_destroy => true
    #attr_accessible :name, :presentation, :description, :customizable_product_options_attributes

    def backed_by_class?
      backing_class_name.present?
    end
  end
end
