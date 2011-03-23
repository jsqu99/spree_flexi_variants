class CustomizedProductOption < ActiveRecord::Base
  belongs_to :customization
  belongs_to :customizable_product_option


  # in populate, params[:customization] contains all the fields supplied by the customization_type_view.
  # those values are saved here

  # label :string
  # value :string            # what the user entered
end
