Feature: Generic List Function
  As a car owner
  In order to know much I spend on gas
  I want to list out all my fuel receipts

  # # Usage:
  #   `./mileage list`
  #
  # # Acceptance Criteria:
  #   * Returns a tabular list of all entered transaction data
  #   * If not enough information is available, it informs me to enter more data

  Scenario: No entries
    Given I have no entries
    When I use the 'list' argument
    Then It should prompt me to enter more data

  Scenario: One or more entries
    Given I have at least one fuel entries
    When I use the 'list' argument
    Then It should display a tabular list of all entered transaction data
