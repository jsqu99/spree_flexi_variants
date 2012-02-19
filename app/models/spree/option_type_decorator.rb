module Spree
  OptionType.class_eval do
    has_many :ad_hoc_option_types, :dependent => :destroy
  end
end
