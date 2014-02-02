@pending
Feature: Generic Total Fuel Spent
  As a car owner
  In order to know much I spend on gas
  I want to know the total fuel spent

  # # Usage:
  #   `./mileage stats total fuel`
  #
  # # Acceptance Criteria:
  #   * Prints out total gallons spent between the earliest and latest entries
  #   * If not enough information is available, it informs me to enter more data

  Scenario: One or fewer entries
    Given I have less than two entries
    When I use the 'stats total fuel' argument
    Then It should prompt me to enter more data

  Scenario: Two or more entries
    Given I have at least two fuel entries
    When I use the 'stats total fuel' argument
    Then It should display the summed total gallons from my entered receipts
