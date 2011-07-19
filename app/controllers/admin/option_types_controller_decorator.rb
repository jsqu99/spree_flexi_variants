Admin::OptionTypesController.class_eval do
  # not sure if I have to repeat the 'before_filter' for the original option_types account 
  before_filter :load_product_decorator, :only => [:select_ad_hoc, :available_ad_hoc]

  def available_ad_hoc
    set_available_ad_hoc_option_types
    render :layout => false
  end

  # AJAX method for selecting an existing option type and associating with the current product
  def select_ad_hoc
    @product.ad_hoc_option_types << AdHocOptionType.new(:option_type => OptionType.find(params[:id]))
    ad_hoc_option_type = @product.ad_hoc_option_types.last

    redirect_to edit_admin_ad_hoc_option_type_url(ad_hoc_option_type)
  end

  private
    def set_available_ad_hoc_option_types
      @available_option_types = OptionType.all
      selected_option_types = []
      @product.ad_hoc_option_types.each do |option|
        selected_option_types << option.option_type
      end
      @available_option_types.delete_if {|ot| selected_option_types.include? ot}
    end

    def load_product_decorator
      load_product
    end

end
