class CustomizedProductOption < ActiveRecord::Base
  belongs_to :product_customization
  belongs_to :customizable_product_option

  mount_uploader :customization_image, CustomizationImageUploader

  def empty?
    value.empty? && customization_image.nil?
  end
  # in populate, params[:customization] contains all the fields supplied by the customization_type_view.
  # those values are saved here

  # value :string            # what the user entered
end
