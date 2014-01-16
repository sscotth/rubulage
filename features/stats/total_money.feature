Feature: Generic Total Amount Spent
  As a car owner
  In order to know much I spend on gas
  I want to know the total amount spent

  # # Usage:
  #   `./mileage stats total money`

  # # Acceptance Criteria:
  #   * Prints out total money spent between the earliest and latest entries
  #   * If not enough information is available, it informs me to enter more data.

  Scenario: One or fewer entries
    Given I have less than two entries
    When I use the 'stats total money' argument
    Then It should prompt me to enter more data

  Scenario: Two or more entries
    Given I have at least two fuel entries
    When I use the 'stats total money' argument
    Then It should display the summed total spent from my entered receipts
