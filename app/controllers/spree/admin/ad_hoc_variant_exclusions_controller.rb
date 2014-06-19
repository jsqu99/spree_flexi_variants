module Spree
  class Admin::AdHocVariantExclusionsController < Admin::ResourceController

    before_filter :load_product, :only => [:index, :new, :create]

    def create

      return unless params["ad_hoc_option_type"]

      ave= AdHocVariantExclusion.new

      params["ad_hoc_option_type"].each_pair do |otid, ovid|
        next if ovid.empty?
        eov=ExcludedAdHocOptionValue.create(:ad_hoc_variant_exclusion => ave, :ad_hoc_option_value_id => ovid)
      end

      ave.product=@product
      ave.save
      redirect_to admin_product_ad_hoc_variant_exclusions_path(@product)
    end

    # TODO how is this different than the default 'destroy'.  maybe I don't need this method
    def remove
      @product=@ad_hoc_variant_exclusion.product
      @ad_hoc_variant_exclusion.destroy
      flash.notice = I18n.t("notice_messages.ad_hoc_variant_exclusion_removed")
      redirect_to admin_product_ad_hoc_variant_exclusions_path(@product)
    end

    protected

    private
    def load_product
      @product = Product.find_by_param!(params[:product_id])
    end

  end
end
