module Spree
  class ProductCustomizationType < ActiveRecord::Base
    include Spree::Core::CalculatedAdjustments
    self.table_name = "spree_product_customization_types"

    has_and_belongs_to_many :products, join_table: "spree_product_customization_types_products"

    has_many :customizable_product_options, :dependent => :destroy
    accepts_nested_attributes_for :customizable_product_options, :allow_destroy => true

    attr_accessible :name, :presentation, :description, :customizable_product_options_attributes
  end
end
