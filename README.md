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

    # Important! - see disclaimer about edge code in the spree groups announce: http://groups.google.com/group/spree-user/browse_thread/thread/2002a5a8e38d71aa#
    gem 'spree', :git => 'git://github.com/spree/spree.git'
    gem 'spree_flexi_variants', :git=>'git@github.com:jsqu99/spree_flexi_variants.git'

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
