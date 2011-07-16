Version Notes
=============

NOTE: July 16, 2011 - I'm having some issues w/ master ATM.  If you are ok w/ living on the edge, use master, as it is more feature-rich.

I'm having a problem w/ including carrierwave correctly (for image customizations).  Hopefully I'll have this resolved in the next 24 hours,
so if you are not deploying immediately and want to check the extension out, use master.

Spree 0.60.* is the only known working version ATM.  Stay tuned.

The pre-deface-stable branch is the most stable.

The master branch has many more features (include image customization).  I'm working on writing some more tests and this will soon be the winner.

SpreeFlexiVariants
==================

This is a [spree](http://spreecommerce.com) extension that solves two use cases related to variants.  I call them **Ad Hoc Options** and **Product Customizations**.

Ad Hoc Options
--------------

Use these when have numerous (possibly price-altering) product options and you don't want to create variants for each combination.

You can also restrict certain combinations of options from coexisting.  These are called **Ad Hoc Exclusions** and are described in more detail in the wiki.


Product Customizations
----------------------

Use these when you want the ability to provide a highly customized product e.g. "Cut to length 5.82cm", "Engrave 'thanks for the memories'".  Full control over pricing is provided by the Spree calculator mechanism.


Installation
------------
    rails new myapp
    cd myapp

Add to Gemfile:

    # for master
    gem 'spree', :git => 'git://github.com/spree/spree.git'
    gem 'json'
    gem 'rmagick'
    gem 'carrierwave'
    gem 'spree_flexi_variants', :git=>'git@github.com:jsqu99/spree_flexi_variants.git'

    # alternatively, if you want to use a stable, spree 0.60.x version:
    # gem 'spree', '0.60.0'
    # gem 'json'
    # gem 'rmagick'
    # gem 'carrierwave'
    # gem 'spree_flexi_variants', :git=>'git@github.com:jsqu99/spree_flexi_variants.git', :branch => 'pre-deface-stable'

    bundle install

    bundle exec rake db:create && bundle exec rails g spree:site && bundle exec rake spree:install && bundle exec rake spree_flexi_variants:install && bundle exec rake db:bootstrap

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
