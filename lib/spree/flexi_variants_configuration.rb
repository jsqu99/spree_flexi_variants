class Spree::FlexiVariantsConfiguration < Spree::Preferences::Configuration
  preference :use_javascript_pricing_updates, :boolean, :default => true
  preference :use_separate_customizations_page, :boolean, :default => false
end
