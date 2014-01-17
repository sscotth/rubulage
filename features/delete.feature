Feature: Generic Delete Function
  As a car owner
  In order to know much I spend on gas
  I want to delete a previously entered fuel receipt

  # # Usage:
  #   `./mileage delete id`
  #
  # # Acceptance Criteria:
  #   * If id is invalid, it informs me that the id is invalid
  #   * Returns data from entry
  #   * Asks for confirmation

  Scenario: Invalid ID
    Given I have an invalid id
    When I use the 'delete id' argument
    Then It should display 'Invalid Id. Use "list" to find the id and try again.'
    And It should update the entry to the database

  Scenario: No Confirmation
    Given I have a valid id
    When I use the 'delete id' argument
    Then It should display the entry's data and ask to confirm deletion.
    When I press any key other than 'y'
    Then It should display 'Canceled'

  Scenario: Confirmed
    Given I have a valid id
    When I use the 'delete id' argument
    Then It should display the entry's data and ask to confirm deletion.
    When I press 'y'
    Then It should delete the entry from the database
    And It should display 'Deleted!'
