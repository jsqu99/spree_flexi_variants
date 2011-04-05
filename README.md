SpreeOnDemandVariants (we should change the name of this, IMO. will discuss soon)
=====================

**STATUS**: not yet production-ready, but getting close.

First cut at some 'real' documentation

This is a [spree](http://spreecommerce.com) extension that solves two main use cases.  I call them **Ad Hoc Variants** and **Product Customizations**.  


Ad Hoc Variants
----------------------

You have numerous many (possibly price-altering) product options and you don't want to create variants for each combination.

### Simple Example
Let's create a pizza product.  There are several possible approaches. I'm going to show a mix of 'traditional' varants with 'ad-hoc' variants here, although we could've gone only one 'type'.

I'll create 3 'traditional' spree variants for size (small, medium, and large).  The other options (toppings) will be handled by ad-hoc variants.

Imagine numerous toppings options (pepperoni, sausage, onions, mushrooms, ham, pineapple).  Imagine also that each topping is priced differently (e.g. pepperoni is $2, mushrooms are $1.25).

On the short list of features is the ability to make price adjustments dependent on outside factors (like pepperoni added to a small pizza is $2, and to a medium pizza $3, etc.).

Let's now use the admin app to create these ad-hoc variants

### Administration

Refer to the [spree documentation](http://spreecommerce.com/documentation/overview) for the details on how to add option types and option values.

You'll create option types 'size' and 'toppings', and add the associated option values.

Create a product 'pizza', and add those option types.

Create 3 variants for the sizes.

From there, go into the *Ad Hoc Variant Option Types* tab on the bottom right.

Add the 'toppings' option type, and you'll be redirected to a screen that displays all the possible toppings, with a price field.

Give each a price (leave some of them 0.00 if you like).

Now go into the store and see the toppings drop down for the pizza.  Add it to the cart and look at the description.

### Ad Hoc Variant Exclusions

You might have a small subset of unavailable option combinations.  This subset is called an *Ad Hoc Variant Exclusion*. This feature is important but not yet implemented.  It is #1 in the priority list.


Product Customizations
----------------------

You want the ability to provide a highly customized product e.g. "Cut to length 5.82cm", "Engrave 'thanks for the memories, Sarah'".

### Simple Example

Let's create a 'rope' product.  I only sell one type of rope, but I'll cut it any length.

### Administration

Inside the admin app, click 'Products', then click the *Customization Types* sub-menu item..

Create a new type called 'length_customization' with presentation 'Cut to length'.  Leave the description blank. Select the product length calculator.

Once created, put in some options for the calculator and update.

After updating, add some customizable options at the bottom.

Now create the rope product then click the *Customization Types* tab on the bottom right.

You'll see there are no customization types added to the product.

Click the 'Add Product Customization Type' link and select the length_customization to the product.

Now go to the store, select the rope, enter the desired length, and add to cart.


Complex Examples
----------------

Code-Level Detail
-----------------

Product Pricing Display Options
-------------------------------

By default, prices aren't updated automatically on the product display page.  If you set
    Spree::Config[:use_ajax_pricing_updates]=true
You'll get pricing changes every time a user changes a price-altering selection.  This option causes the 'products/pricing' partial to be included.


Copyright (c) 2011 Jeff Squires, released under the New BSD License
