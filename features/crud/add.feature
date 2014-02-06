Feature: Generic Add Function
  As a car owner with a fuel receipt
  In order to know much I spend on gas
  I want to enter in my fuel receipts

  Scenario: Proper Normal Entry
    When I successfully use the "add -d 2014-1-1 -o 123 -p 123 -g 12" option
    Then the output should contain "Saved!"
    And the output should match /\+-+\+/
    And the output should contain "01/01/2014"

  Scenario: Missing Field
    When I use the "add -d 2014-1-1 -o 123 -p 123" option
    Then the output should contain "missing argument: gallons"
    And the exit status should be 1

  Scenario: Missing Multiple Fields
    When I use the "add" option
    Then the output should contain "missing argument: date odometer gallons price"
    And the exit status should be 1
