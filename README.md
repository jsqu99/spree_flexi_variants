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


Version Notes
=============

The branch you are currently on (master) is an upgrade-in-progress to spree 1.0.  Consider it beta right now.

Please see the Versionfile for working spree 0.70 and  spree 0.60 versions

Version 2
----------
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

Installation
------------
    # see the notes in Versionfile if you are using an older version of spree
    gem 'rmagick'
    gem 'carrierwave'
    gem 'spree_flexi_variants', :git=>'git@github.com:jsqu99/spree_flexi_variants.git'

    bundle install

    bundle exec rails g spree_flexi_variants:install

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
