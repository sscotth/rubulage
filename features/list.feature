Feature: Generic List Function
  As a car owner
  In order to know much I spend on gas
  I want to list out all my fuel receipts

  # # Usage:
  #   `./mileage list [id]`
  #
  # # Acceptance Criteria:
  #   * Returns data from entry, or if no id is passed, a list of all entered data
  #   * If not enough information is available, it informs me to enter more data
  #   * If id is invalid, it informs me that the id is invalid

  Scenario: Request All Entries
    Given I have at least one fuel entry
    When I use the 'list' argument
    Then It should display a list with each transaction's data

  Scenario: No entries
    Given I have no entries
    When I use the 'list' argument
    Then It should prompt me to enter more data

  Scenario: Request Single Entry
    Given I have a valid id
    When I use the 'list id' argument
    Then It should display the id's transaction data

  Scenario: Invalid ID
    Given I have an invalid id
    When I use the 'list id' argument
    Then It should display 'Invalid Id. Use "list" to find the id and try again.'
