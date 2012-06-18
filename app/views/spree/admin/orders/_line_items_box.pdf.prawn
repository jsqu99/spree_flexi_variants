if @hide_prices
  @column_widths = { 0 => 100, 1 => 165, 2 => 75, 3 => 75 } 
  @align = { 0 => :left, 1 => :left, 2 => :right, 3 => :right }
else
  @column_widths = { 0 => 75, 1 => 205, 2 => 75, 3 => 50, 4 => 75, 5 => 60 } 
  @align = { 0 => :left, 1 => :left, 2 => :left, 3 => :right, 4 => :right, 5 => :right}
end

# Line Items
bounding_box [0,cursor], :width => 540, :height => 430 do
  move_down 2
  header =  [Prawn::Table::Cell.new( :text => t(:sku), :font_style => :bold),
                Prawn::Table::Cell.new( :text => t(:item_description), :font_style => :bold ) ]
  header <<  Prawn::Table::Cell.new( :text => t(:options), :font_style => :bold ) 
  header <<  Prawn::Table::Cell.new( :text => t(:price), :font_style => :bold ) unless @hide_prices
  header <<  Prawn::Table::Cell.new( :text => t(:qty), :font_style => :bold, :align => 1 )
  header <<  Prawn::Table::Cell.new( :text => t(:total), :font_style => :bold ) unless @hide_prices
    
  table [header],
    :position           => :center,
    :border_width => 1,
    :vertical_padding   => 2,
    :horizontal_padding => 6,
    :font_size => 9,
    :column_widths => @column_widths ,
    :align => @align

  move_down 4

  bounding_box [0,cursor], :width => 540 do
    move_down 2
    content = []
    @order.line_items.each do |item|
      row = [ item.variant.product.sku, item.variant.product.name]
      row << variant_options(item.variant)
      row << number_to_currency(item.price) unless @hide_prices
      row << item.quantity
      row << number_to_currency(item.price * item.quantity) unless @hide_prices
      content << row
      item.ad_hoc_option_values.each do |pov|
        row = ['', pov.option_value.option_type.presentation, pov.option_value.presentation, '', '', '']
        content << row
      end
    end


    table content,
      :position           => :center,
      :border_width => 0.5,
      :vertical_padding   => 5,
      :horizontal_padding => 6,
      :font_size => 9,
      :column_widths => @column_widths ,
      :align => @align
  end

  font "Helvetica", :size => 9

  bounding_box [20,cursor  ], :width => 400 do
    render :partial => "bye" unless @hide_prices
  end

  render :partial => "totals" unless @hide_prices
  
  move_down 2

  stroke do
    line_width 0.5
    line bounds.top_left, bounds.top_right
    line bounds.top_left, bounds.bottom_left
    line bounds.top_right, bounds.bottom_right
    line bounds.bottom_left, bounds.bottom_right
  end

end
