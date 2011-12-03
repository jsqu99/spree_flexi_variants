Version Notes
=============

This is the rails 3.1-compatible version.  It is bleeding edge, but there are no known issues at this point.

I'm excited to announce that I'm working feverishly on a complete rewrite (currently in the v2 branch (and highly pre-alpha), if you are curious).

After using this extension in a few projects, I discovered some areas for improvement.

The goal with the next version is to:

* Allow the extension to play nicely with all other extensions.

The current version does major surgery on (and changes the parameters of) Order#add_variant.  This interferes with some other extensions.
Version 2  will be far less intrusive on the existing spree models

* Keep the notion of a *variant*.

The current version does not allow you to later look up the variant and be able to reconstruct its state.  This is all at the LineItem level now.

* Allow more advanced pricing (dependent options, etc.)

* Allow skus to be computed based on the selected options

* Less cumbersome traversing of the object graph.

* Better image customization support

* Fewer new models!


SpreeFlexiVariants
==================

This is a [spree](http://spreecommerce.com) extension that solves two use cases related to variants.  I call them **Ad Hoc Options** and **Product Customizations**.

Ad Hoc Options
--------------

Use these when have numerous (possibly price-altering) product options and you don't want to create variants for each combination.

You can also restrict certain combinations of options from coexisting.  These are called **Ad Hoc Exclusions** and are described in more detail in the wiki.


Product Customizations
----------------------

Use these when you want the ability to provide a highly customized product e.g. "Cut to length 5.82cm", "Engrave 'thanks for the memories'", "Upload my image".  Full control over pricing is provided by the Spree calculator mechanism.


Installation
------------


NOTE: there is currently an issue w/ the 0-70-stable branch of spree.  I have an outstanding question: http://groups.google.com/group/spree-user/browse_thread/thread/80810dc0d907d6ac

Once I figure this out I'll update the README.

In the meantime, follow the instructions below and you _should_ be ok

    rails new myapp
    cd myapp

Add to Gemfile (NOTE: spree master is currently unsupported!  The namespace changes are not yet reflected in this extension).
    gem 'spree', :git => 'git://github.com/spree/spree.git', :branch => '0-70-stable'
    gem 'rmagick'
    gem 'carrierwave'
    gem 'spree_flexi_variants', :git=>'git@github.com:jsqu99/spree_flexi_variants.git'

    bundle install

    # I'm still figuring out how to correctly bootstrap the edge-spree version.  Unsure of this below:

    # bundle exec rails g spree:site
    # bundle exec rake spree_flexi_variants:install:assets
    bundle exec rake railties:install:migrations

Temporarily work around the issue where the migrations are copied over to your app's db/migrate from the extension's db/migrate but remamed w/ different timestamps, causing them to be mistakenly run twice.  I believe the railties:install:migrations is necessary b/c you get a missing 'countries' error if you don't.  My apologies, I don't fully understand the engine asset/migration mechanism in rails 3.1 just yet.

So, remove these by hand from you app's db/migrate dir:

    rm db/migrate/*_create_ad_hoc_option_types.rb
    rm db/migrate/*_create_ad_hoc_option_values.rb
    rm db/migrate/*_create_product_customizations.rb
    rm db/migrate/*_create_product_customization_types.rb
    rm db/migrate/*_create_ad_hoc_variant_exclusions.rb
    rm db/migrate/*_create_customized_product_options.rb
    rm db/migrate/*_create_customizable_product_options.rb
    rm db/migrate/*_create_excluded_ad_hoc_option_values.rb
    rm db/migrate/*_create_ad_hoc_option_values_line_items.rb
    rm db/migrate/*_customization_validations.rb
    rm db/migrate/*_add_carrierwave_fields.rb
    rm db/migrate/*_remove_data_validation_string.rb
    rm db/migrate/*_add_id_to_ad_hoc_option_values_line_items.rb
    rm db/migrate/*_add_position_to_ad_hoc_option_values.rb

    bundle exec rake db:bootstrap

## Examples


Build a 'Cake'  product using **Ad Hoc Options** and **Product Customizations**

![Cake](/jsqu99/spree_flexi_variants/raw/master/doc/cake_screenshot.png)

Build a 'Necklace'  product using **Ad Hoc Options** and **Product Customizations**

![Necklace](/jsqu99/spree_flexi_variants/raw/master/doc/necklace_screenshot.png)

Build a 'Pizza' product using **Ad Hoc Options**. Note that the 'multi' option checkboxes come from a partial named after the option name (see app/views/products/ad_hoc_options/_toppings.html.erb)

![Picture Frame](/jsqu99/spree_flexi_variants/raw/master/doc/pizza_screenshot.png)

See the [wiki](https://github.com/jsqu99/spree_flexi_variants/wiki) for more detail.

Many, many thanks to [Brian Quinn](https://github.com/BDQ) for selflessly volunteering his time to mentor me throughout the development process.

Copyright (c) 2011 Jeff Squires, released under the New BSD License
