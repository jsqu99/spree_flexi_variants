class CustomizationsController < Spree::BaseController
  include Customizations

  # POST /customizations/price
  def price

    # TODO: reuse orders_controlller.customizations private method
    c = customizations

    respond_to do |format|
      format.js {render :text=>"#{c.map(&:price).sum}" }
    end
  end

end
