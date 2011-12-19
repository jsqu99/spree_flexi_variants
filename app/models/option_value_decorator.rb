OptionValue.class_eval do
  has_one :ad_hoc_option_value, :dependent => :destroy
  has_many :excluded_ad_hoc_option_values, :dependent => :destroy
end
