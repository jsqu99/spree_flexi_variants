Given /^an option type exists$/ do
  Factory(:option_type)
end

When /^I visit the admin products option types page$/ do
  visit('/admin/option_types')
end

Then /^I should see tabular data for option types index$/ do
  output = tableish('table#listing_option_types tr', 'td,th')
  data = output[0]
  data[0].should == 'Name'

  data = output[1]
  data[0].should == OptionType.limit(1).order('name ASC').to_a.first.name
end

Then /^I should see the following in the option types index:$/ do |table|

  # table is a Cucumber::Ast::Table
  output = tableish('table#listing_option_types tr', 'td,th')
  data = output[1]

  hash = table.hashes.first
  # data[0].should == hash  not sure what to write here
# example from railscasts is:

#Given /^the following user records$/ do |table|
#  table.hashes.each do |hash|
#    Factory(:user, hash)
#  end
#end

end

Given /^I have a "([^"]*)" pricing strategy$/ do |strategy_name|
  case strategy_name
  when "Fixed Amount"
    Factory(:amount_option_pricing_strategy)
  end
end

Given /^I have an? "([^"]*)" select box$/ do |arg1|
  page.has_select?(arg1) # , :options => ['English', 'German'])
end

Given /^I have an? "([^"]*)" check box$/ do |arg1|
  page.has_checked_field?(arg1) || page.has_no_checked_field?(arg1)  # i suspect there's a smarter way to test existence of a checkbox  ...   page.has_field?(field) ?
end

Then /^I should see field "([^"]*)" with value "([^"]*)"$/ do |field, value|
  page.has_field?(field, :with => value)
end

Then /^the checkbox "([^"]*)" should be "([^"]*)"$/ do |field, checked_or_unchecked|
  case checked_or_unchecked
  when "checked"
    page.has_checked_field?(field)
  when "unchecked"
    page.has_no_checked_field?(field)
  end
end
