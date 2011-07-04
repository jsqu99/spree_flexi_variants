class FlexiVariantsConfiguration < Configuration
  preference :use_javascript_pricing_updates, :boolean, :default => true
  preference :use_separate_customizations_page, :boolean, :default => false

  validates_presence_of :name
  validates_uniqueness_of :name
end
