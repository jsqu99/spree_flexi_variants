class ProductCustomizationsController < Spree::BaseController
  include ProductCustomizations

  # POST /product_customizations/price
  def price

    c = product_customizations

    respond_to do |format|
      format.js {render :text=>"#{c.map(&:price).sum}" }
    end
  end

end
