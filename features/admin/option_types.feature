Feature: Admin > Option Types

  Scenario: admin visiting option types list
    Given I am signed in as an admin
    Given an option type exists
    When I go to the admin products option types page
    Then I should see "Option Types"
    Then I should see tabular data for option types index

  Scenario: admin adding a new option type
    Given I am signed in as an admin
    When I go to the admin products option types page
    When I follow "New Option Type"
    Then I should see "New Option Type"
    When I fill in "Name" with "tshirt_size"
    When I fill in "Presentation" with "TShirt Size"
    Given I have a "Fixed Amount" pricing strategy
    When I select "Fixed Amount" from "Pricing Strategy"
    Given I have a "SKU Strategy" select box
    Given I have an "Inventory Strategy" select box
    When I check "Required?"
    Given I have an "Allow Multiple Values?" check box
    Given I have an "allow_custom_text" check box
    Given I have an "allow_custom_image" check box
    When I press "Create"
    Then I should see "Edit Option Type"


    Then I should see field "Name" with value "tshirt_size"
    Then I should see field "Presentation" with value "TShirt Size"
    Then I should see field "Pricing Strategy" with value "Fixed Amount"
    Then the checkbox "Required?" should be "checked"
    Then the checkbox "Allow Multiple Values?" should be "unchecked"
    Then the checkbox "allow_custom_text" should be "unchecked"
    Then the checkbox "allow_custom_image" should be "unchecked"

    When I press "Update"

    Then I should see the following in the option types index:
      | tshirt_size | TShirt Size | Fixed Amount | N/A | N/A | Yes | No | No | No |
      #    Then show me the page

