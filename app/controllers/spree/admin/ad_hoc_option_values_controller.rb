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
  end
end
