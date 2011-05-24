Factory.define :product_area, :class => Calculator::ProductArea do |f|
  f.after_create do |c|
    c.set_preference(:multiplier, 10.0)
    c.set_preference(:min_pricing_area, 20)
    c.set_preference(:min_width, 5)
    c.set_preference(:max_width, 50)
    c.set_preference(:min_height, 4)
    c.set_preference(:max_height, 40)
  end
end

