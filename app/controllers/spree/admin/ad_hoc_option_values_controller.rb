module Spree
  class Admin::AdHocOptionValuesController < Admin::ResourceController
    def update_positions
      params[:positions].each do |id, index|
        AdHocOptionValue.update_all(['position=?', index], ['id=?', id])
      end

      respond_to do |format|
        format.js  { render :text => 'Ok' }
      end
    end

    def destroy
      ad_hoc_option_value = AdHocOptionValue.find(params[:id])
      ad_hoc_option_value.destroy
      redirect_to edit_admin_product_ad_hoc_option_type_path(
        ad_hoc_option_value.ad_hoc_option_type.product_id,
        ad_hoc_option_value.ad_hoc_option_type_id)
    end
  end
end
