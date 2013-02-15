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
      render :text => nil
    end
  end
end
