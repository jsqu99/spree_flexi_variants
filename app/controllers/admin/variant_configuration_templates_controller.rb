class Admin::VariantConfigurationTemplatesController < Admin::BaseController
  resource_controller
  belongs_to :product

  # on create, we want to load the pool of product_option_types 

end
