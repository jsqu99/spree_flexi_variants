module Spree
  class Admin::ProductCustomizationTypesController < Admin::ResourceController
    before_filter :load_product, :only => [:selected, :available, :remove]
    before_filter :load_calculators, :only => [:new, :edit]

    def load_calculators
      @calculators = ProductCustomizationType.calculators.sort_by(&:name)
    end

    def edit
      @product_customization_type= ProductCustomizationType.find(params[:id])

      # Is this an edit immediately after create?  If so, need to create
      # calculator-appropriate default options
      if @product_customization_type.customizable_product_options.empty?
        if !@product_customization_type.calculator.nil?

          opts = @product_customization_type.calculator.create_options
          @product_customization_type.customizable_product_options.concat opts if opts

          # for each mandatory input type
          #        @product_customization_type.calculator.required_fields.each_pair do |key, val|
          #          cpo= CustomizableProductOption.create(:name=>key, :presentation=>key.titleize, :is_required => true,:data_type=>val)
          #          @product_customization_type.customizable_product_options << cpo
          #        end
        end
      end
    end

    def available
      set_available_product_customization_types
      render :layout => false
    end

    def selected
      @product_customization_types = @product.product_customization_types
    end

    def remove
      @product.product_customization_types.delete(@product_customization_type)
      @product.save
      flash.notice = I18n.t("notice_messages.product_customization_type_removed")
      redirect_to selected_admin_product_product_customization_types_url(@product)
    end


    # AJAX method for selecting an existing option type and associating with the current product
    def select
      @product = Product.find_by_param!(params[:product_id])

      @product.product_customization_types << ProductCustomizationType.find(params[:id])
      @product.save
      @product_customization_types = @product.product_customization_types
      set_available_product_customization_types
    end

    protected

    def location_after_save
      if params[:action] == "update"
        admin_product_customization_types_url
      else
        edit_admin_product_customization_type_url(@product_customization_type)
      end
    end


    private
    def load_product
      @product = Product.find_by_param!(params[:product_id])
    end

    def set_available_product_customization_types
      @available_product_customization_types = ProductCustomizationType.all
      selected_product_customization_types = []
      @product.product_customization_types.each do |pct|
        selected_product_customization_types << pct
      end
      @available_product_customization_types.delete_if {|pct| selected_product_customization_types.include? pct}
    end
  end
end
