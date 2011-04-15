SpreeFlexiVariants
==================

This is a [spree](http://spreecommerce.com) extension that solves two use cases related to variants.  I call them **Ad Hoc Options** and **Product Customizations**.  

Installation
------------
    rails new myapp
    cd myapp


Add to Gemfile:

    gem 'spree'
    gem 'spree_flexi_variants', :git=>'git@github.com:jsqu99/spree_flexi_variants.git'

    bundle install

    rake db:create && rails g spree:site && rake spree:install && rake spree_flexi_variants:install && rake db:bootstrap

If you choose 'yes' to install the sample data, the contents of db/sample will be loaded with some sample products that take advantage of this extension.

Ad Hoc Options
----------------------

Use these when have numerous (possibly price-altering) product options and you don't want to create variants for each combination.

Product Customizations
----------------------

Use these when you want the ability to provide a highly customized product e.g. "Cut to length 5.82cm", "Engrave 'thanks for the memories, Sarah'".


## Examples

![Cake](/jsqu99/spree-flexi-variants/raw/master/doc/cake.jpg)
![Necklace](/jsqu99/spree-flexi-variants/raw/master/doc/necklace.jpg)
![Pizza](/jsqu99/spree-flexi-variants/raw/master/doc/pizza.jpg)
![Picture Frame](/jsqu99/spree-flexi-variants/raw/master/doc/frame.jpg)


See the wiki for more detail

Copyright (c) 2011 Jeff Squires, released under the New BSD License
