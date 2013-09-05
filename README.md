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

The branch you are currently on (master) is an upgrade-in-progress to spree 1.1.  Consider it beta right now.

Please see the Versionfile for working spree 1.0, 0.70 and  spree 0.60 versions


Installation
------------
    # see the notes in Versionfile if you are using an older version of spree
    gem 'spree_flexi_variants', :git=>'git@github.com:jsqu99/spree_flexi_variants.git'

    bundle install

    bundle exec rails g spree_flexi_variants:install

## Examples


Build a 'Cake'  product using **Ad Hoc Options** and **Product Customizations**

![Cake](https://raw.github.com/jsqu99/spree_flexi_variants/master/doc/cake_screenshot.png)

Build a 'Necklace'  product using **Ad Hoc Options** and **Product Customizations**

![Necklace](https://raw.github.com/jsqu99/spree_flexi_variants/master/doc/necklace_screenshot.png)

Build a 'Pizza' product using **Ad Hoc Options**. Note that the 'multi' option checkboxes come from a partial named after the option name (see app/views/products/ad_hoc_options/_toppings.html.erb)

![Picture Frame](https://raw.github.com/jsqu99/spree_flexi_variants/master/doc/pizza_screenshot.png)

See the [wiki](https://github.com/jsqu99/spree_flexi_variants/wiki) for more detail.

Many, many thanks to [Brian Quinn](https://github.com/BDQ) for selflessly volunteering his time to mentor me throughout the development process.

Copyright (c) 2011 Jeff Squires, released under the New BSD License
