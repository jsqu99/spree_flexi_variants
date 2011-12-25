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
    # we'll fix the typo down below
    When I fill in "Presentation" with "TShirt eziS"
    Given I have a "Fixed Amount" pricing strategy
    When I select "Price adjustment (amount) per option value" from "option_pricing_strategy"
    Given I have a "SKU Strategy" select box
    Given I have an "Inventory Strategy" select box
    When I check "Required?"
    Given I have an "Allow Multiple Values?" check box
    Given I have an "allow_custom_text" check box
    Given I have an "allow_custom_image" check box
    When I press "Create"
    Then I should see "Editing Option Type"


    Then I should see field "Name" with value "tshirt_size"
    Then I should see field "Presentation" with value "TShirt eziS"
    #fixed the typo from above
    When I fill in "Presentation" with "TShirt Size"

    Then I should see field "option_pricing_strategy" with value "Price adjustment (amount) per option value"
    Then the checkbox "Required?" should be "checked"
    Then the checkbox "Allow Multiple Values?" should be "unchecked"
    Then the checkbox "allow_custom_text" should be "unchecked"
    Then the checkbox "allow_custom_image" should be "unchecked"

    # need to add option values next
    Then show me the page
    When I press "Update"

    Then I should see the following in the option types index:
      | tshirt_size | TShirt Size | Price adjustment (amount) per option value | N/A | N/A | Yes | No | No | No |
      #    Then show me the page

