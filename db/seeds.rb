# had to get these out of the activate method because Spree::Config didn't yet exist
Spree::Config.set :use_javascript_pricing_updates => true
Spree::Config.set :use_separate_customizations_page => false
