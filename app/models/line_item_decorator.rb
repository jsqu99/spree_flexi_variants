LineItem.class_eval do

  # saw this in the logs, so need to change below...but how????
  # DEPRECATION WARNING: Having additional attributes on the join table of a has_and_belongs_to_many association is deprecated and will be removed in Rails 3.1. Please use a has_many :through association instead. (called from contains? at /home/jsquires/src/ext_test/spree_on_demand_variants/lib/../app/models/order_decorator.rb:48)

  has_and_belongs_to_many :ad_hoc_variant_option_values

  # has_many :ad_hoc_variant_option_values, :through => 
  has_many :product_customizations 
end
