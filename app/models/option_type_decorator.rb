OptionType.class_eval do
  has_one :ad_hoc_option_type, :dependent => :destroy
end
