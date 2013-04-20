module Spree
  [
AdHocOptionType,
AdHocOptionValue,
AdHocOptionValuesLineItem,
AdHocVariantExclusion,
CustomizableProductOption,
CustomizedProductOption,
ExcludedAdHocOptionValue,
ProductCustomization,
ProductCustomizationType
].each do |model|
      model.send(:include, SpreeLandlord::TenantedModel)
    end
end
