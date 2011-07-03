Version Notes
=============

NOTE: July 2, 2011 - Just made some major updates to master.  I attempted to test against spree master with no luck.

Spree 0.60.* is the only known working version ATM.  Stay tuned.

SpreeFlexiVariants
==================

This is a [spree](http://spreecommerce.com) extension that solves two use cases related to variants.  I call them **Ad Hoc Options** and **Product Customizations**.

Ad Hoc Options
--------------

Use these when have numerous (possibly price-altering) product options and you don't want to create variants for each combination.

You can also restrict certain combinations of options from coexisting.  These are called **Ad Hoc Exclusions** and are described in more detail in the wiki.


Product Customizations
----------------------

Use these when you want the ability to provide a highly customized product e.g. "Cut to length 5.82cm", "Engrave 'thanks for the memories, Sarah'".  Full control over pricing is provided by the Spree calculator mechanism.


Installation
------------
    rails new myapp
    cd myapp

Add to Gemfile:

    # see the notes above regarding the fact that edge currently doesn't work (the price doesn't update due to a deface integration issue that we are currently working)
    gem 'spree', :git => 'git://github.com/spree/spree.git'
    gem 'spree_flexi_variants', :git=>'git@github.com:jsqu99/spree_flexi_variants.git'

    # alternatively, if you want to use a stable, spree 0.60.x version:
    # gem 'spree', '0.60.0'
    # gem 'spree_flexi_variants', :git=>'git@github.com:jsqu99/spree_flexi_variants.git', :branch => 'pre-deface-stable'

    bundle install

    rake db:create && rails g spree:site && rake spree:install && rake spree_flexi_variants:install && rake db:bootstrap

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
