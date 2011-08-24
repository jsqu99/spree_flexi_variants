class Admin::VariantConfigurationsController < Admin::BaseController
  helper :products
  def configure
    @variant = Variant.find(params[:variant_id])

    respond_to do |wants|
      wants.js
    end
  end
end
