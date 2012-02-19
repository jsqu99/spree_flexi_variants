module Spree
  Product.class_eval do
    # These are the pool of POSSIBLE option values
    has_many :ad_hoc_option_types, :after_add => :attach_option_values

    # Each exclusion represents a disallowed combination of ad_hoc_option_values
    has_many :ad_hoc_variant_exclusions, :dependent => :destroy

    # allowed customizations
    has_and_belongs_to_many :product_customization_types


    private

    def attach_option_values(ad_hoc_option_type)
      ad_hoc_option_type.option_type.option_values.each do |ov|
        ad_hoc_option_type.ad_hoc_option_values << AdHocOptionValue.create(:option_value_id=>ov.id)
      end
    end
  end
end
