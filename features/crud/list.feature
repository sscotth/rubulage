Feature: Generic List Function
  As a car owner
  In order to know much I spend on gas
  I want to list out all my fuel receipts

  Background:
    Given the following transaction records
      | date     | odometer | price | gallons |
      | 2014-1-1 | 12345    | 1.009 | 12.5    |
      | 2014-1-2 | 12456    | 1.109 | 12.5    |

  Scenario: Request All Entries
    When I use the "list" command
    Then the output should contain a table
    And the output should contain "01/01/2014"
    And the output should contain "01/02/2014"

    When I use the "list all" command
    Then the output should contain a table
    And the output should contain "01/01/2014"
    And the output should contain "01/02/2014"

  Scenario: Request Single Entry
    When I use the "list" command with an id
    Then the output should contain a table
    And the output should contain "01/02/2014"

  Scenario: Invalid ID
    When I use the "list 99999999999999999" command
    Then the output should contain a table
    And the output should not contain "01/01/2014"
