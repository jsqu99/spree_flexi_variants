OrdersController.class_eval do
  prepend_before_filter :find_or_create_variant

  # TODO: jeff needs to re-learn the differences between params[:products] & params[variants]
  #    params[:variants].each do |variant_id, quantity|

  def find_or_create_variant
    params[:option_values]
  end
end
