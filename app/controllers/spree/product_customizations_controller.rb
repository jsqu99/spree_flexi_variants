module Spree
  class ProductCustomizationsController < Spree::BaseController
    include ProductCustomizations

    # POST /product_customizations/price
    def price
      c = product_customizations

      # now grab the file-upload params.
      # We send in customizable_product_option ids that have pending file uploads
      # CustomizableProductOption
      respond_to do |format|
        format.js {render :text=>"#{c.map(&:price).sum}" }
      end
    end

  end
end
