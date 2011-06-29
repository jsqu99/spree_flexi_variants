If you want a partial based on the name of your customization_type, place it in ./customization_type e.g.


name = 'customization_image'

customization_type/_customization_image.html.erb

If you want a partial based on the name of your customization_type's calculator, place it in ./calculator_type e.g.

calculator = Calc::MyCalc

calculator_type/_my_calc.html.erb

The partials are selected in this order is

1) customization_type
2) calculator_type
