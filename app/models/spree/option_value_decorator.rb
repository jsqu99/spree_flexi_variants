module Spree
  OptionValue.class_eval do
    has_many :ad_hoc_option_values, :dependent => :destroy
  end
end
