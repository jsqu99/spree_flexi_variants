Variant.class_eval do
  # we might need a boolean in the db to indicate dynamic
  # should we somehow override the 'variants' AR method to by default not show these dynamic variants?


  # re: the price.  could we somehow intercept the call to the AR price method, and trigger a
  # 'go find the dynamic price based on the product's calculator?'
end

