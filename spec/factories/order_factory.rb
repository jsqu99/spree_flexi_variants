Factory.define(:order2, :class => Order) do |record|
  # associations:
  record.association(:user, :factory => :user)
  record.association(:bill_address, :factory => :address)
  record.completed_at nil
  record.bill_address_id nil
  record.ship_address_id nil
end


Factory.define :order_with_ad_hoc_options, :parent => :order2 do |f|
  f.after_create { |order| Factory(:line_item_with_ad_hoc_options, :order => order) }
end
