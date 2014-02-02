@pending
Feature: Interactive Update Function
  As a car owner
  In order to know much I spend on gas
  I want to enter update a previously entered fuel receipt

  # # Usage:
  #   `./mileage update id`
  #
  # # Acceptance Criteria:
  #   * If id is invalid, it informs me that the id is invalid
  #   * Asks for necessary information with prior data filled in
  #   * Asks for a total confirmation
  #   * If something fails validation, it informs me the proper usage and to reenter the data

  Scenario: Invalid ID
    Given I have a fuel receipt but an invalid id
    When I use the 'update id' argument
    Then It should display 'Invalid Id. Use "list" to find the id and try again.'
    And It should update the entry to the database

  Scenario: Proper Entry
    Given I have a fuel receipt and the id of the previous entry
    When I use the 'update id' argument
    Then It should prompt me to enter the transaction date with the prior data filled in
    When I enter the transaction date
    Then It should ask if a fill-up was missed between "{#previous_date}" and "#{current_date}" with the prior data filled in
    When I press 'y' or 'n'
    Then It should ask if this was not a complete fill-up with the prior data filled in
    When I press 'y' or 'n'
    Then It should prompt me to enter the odometer reading with the prior data filled in
    When I enter the odometer value
    Then It should prompt me to enter the gallons purchased with the prior data filled in
    When I enter the gallons purchased
    Then It should prompt me to enter the price paid per gallon with the prior data filled in
    When I enter the price paid per gallon
    Then It should prompt me to confirm the entered information with the total amount spent
    When I press 'y' to confirm
    Then It should update the entry to the database
    When The database has been updated
    Then It should display 'Saved!' along with the data entered and its id

  Scenario: Improper Date Entry
    Given I have a fuel receipt the id of the previous entry
    When I use the 'update id' argument
    Then It should prompt me to enter the transaction date with the prior data filled in
    When I enter a non-valid transaction date
    Then It should display 'Cannot parse date. Usage: YYYY-MM-DD [HH:MM:SS]'
    And It should prompt me to enter the transaction date

  Scenario: Improper Missed Fill-up Confirmation
    Given I have a fuel receipt
    When I use the 'update id' argument
    Then It should prompt me to enter the transaction date with the prior data filled in
    When I enter the transaction date
    Then It should ask if a fill-up was missed between "{#previous_date}" and "#{current_date}" with the prior data filled in
    When I press any character other than 'y' or 'n'
    Then It should display 'Cannot confirm. Press "y" or "n"'
    And It should ask if a fill-up was missed between "{#previous_date}" and "#{current_date}" with the prior data filled in

  Scenario: Improper Partial Fill-up Confirmation
    Given I have a fuel receipt
    When I use the 'update id' argument
    Then It should prompt me to enter the transaction date with the prior data filled in
    When I enter the transaction date
    Then It should ask if a fill-up was missed between "{#previous_date}" and "#{current_date}" with the prior data filled in
    When I press 'y' or 'n'
    Then It should ask if this was not a complete fill-up with the prior data filled in
    When I press any character other than 'y' or 'n'
    Then It should display 'Cannot confirm. Press "y" or "n"'
    And It should ask if this was not a complete fill-up with the prior data filled in

  Scenario: Improper Odometer Entry
    Given I have a fuel receipt
    When I use the 'update id' argument
    Then It should prompt me to enter the transaction date with the prior data filled in
    When I enter the transaction date
    Then It should ask if a fill-up was missed between "{#previous_date}" and "#{current_date}" with the prior data filled in
    When I press 'y' or 'n'
    Then It should ask if this was not a complete fill-up with the prior data filled in
    When I press 'y' or 'n'
    Then It should prompt me to enter the odometer reading with the prior data filled in
    When I enter a non-positive or non-numeric string
    Then It should display 'Cannot parse odometer. Usage: 123456.3'
    And It should prompt me to enter the odometer reading

  Scenario: Invalid Odometer Entry
    Given I have a fuel receipt
    When I use the 'update id' argument
    Then It should prompt me to enter the transaction date with the prior data filled in
    When I enter the transaction date
    Then It should ask if a fill-up was missed between "{#previous_date}" and "#{current_date}" with the prior data filled in
    When I press 'y' or 'n'
    Then It should ask if this was not a complete fill-up with the prior data filled in
    When I press 'y' or 'n'
    Then It should prompt me to enter the odometer reading with the prior data filled in
    When I enter a value that is not above the previous entry's value or below the next entry's value
    Then It should display "Invalid odometer reading. Must be between #{previous_reading} [and #{next_reading}]."
    And It should prompt me to enter the odometer reading

  Scenario: Improper Gallons Entry
    Given I have a fuel receipt the id of the previous entry
    When I use the 'update id' argument
    Then It should prompt me to enter the transaction date with the prior data filled in
    When I enter the transaction date
    Then It should ask if a fill-up was missed between "{#previous_date}" and "#{current_date}" with the prior data filled in
    When I press 'y' or 'n'
    Then It should ask if this was not a complete fill-up with the prior data filled in
    When I press 'y' or 'n'
    Then It should prompt me to enter the odometer reading with the prior data filled in
    When I enter the odometer value
    Then It should prompt me to enter the gallons purchased with the prior data filled in
    When I enter a non-positive or non-numeric string
    Then It should display 'Cannot parse gallons. Usage: 12.345'
    And It should prompt me to enter the gallons purchased

  Scenario: Improper Price Entry
    Given I have a fuel receipt the id of the previous entry
    When I use the 'update id' argument
    Then It should prompt me to enter the transaction date with the prior data filled in
    When I enter the transaction date
    Then It should ask if a fill-up was missed between "{#previous_date}" and "#{current_date}" with the prior data filled in
    When I press 'y' or 'n'
    Then It should ask if this was not a complete fill-up with the prior data filled in
    When I press 'y' or 'n'
    Then It should prompt me to enter the odometer reading with the prior data filled in
    When I enter the odometer value
    Then It should prompt me to enter the gallons purchased with the prior data filled in
    When I enter the gallons purchased
    Then It should prompt me to enter the price paid per gallon with the prior data filled in
    When I enter a non-positive or non-numeric string
    Then It should display 'Cannot parse price. Usage: 3.45[9]'
    And It should prompt me to enter the price paid per gallon

  Scenario: Improper Confirmation
    Given I have a fuel receipt the id of the previous entry
    When I use the 'update id' argument
    Then It should prompt me to enter the transaction date with the prior data filled in
    When I enter the transaction date
    Then It should ask if a fill-up was missed between "{#previous_date}" and "#{current_date}" with the prior data filled in
    When I press 'y' or 'n'
    Then It should ask if this was not a complete fill-up with the prior data filled in
    When I press 'y' or 'n'
    Then It should prompt me to enter the odometer reading with the prior data filled in
    When I enter the odometer value
    Then It should prompt me to enter the gallons purchased with the prior data filled in
    When I enter the gallons purchased
    Then It should prompt me to enter the price paid per gallon with the prior data filled in
    When I enter the price paid per gallon
    Then It should prompt me to confirm the entered information with the total amount spent
    When I press any character other than 'y' or 'n'
    Then It should display 'Cannot confirm. Press "y" or "n"'

  Scenario: Unconfirmed Entry
    Given I have a fuel receipt the id of the previous entry
    When I use the 'update id' argument
    Then It should prompt me to enter the transaction date with the prior data filled in
    When I enter the transaction date
    Then It should ask if a fill-up was missed between "{#previous_date}" and "#{current_date}" with the prior data filled in
    When I press 'y' or 'n'
    Then It should ask if this was not a complete fill-up with the prior data filled in
    When I press 'y' or 'n'
    Then It should prompt me to enter the odometer reading with the prior data filled in
    When I enter the odometer value
    Then It should prompt me to enter the gallons purchased with the prior data filled in
    When I enter the gallons purchased
    Then It should prompt me to enter the price paid per gallon with the prior data filled in
    When I enter the price paid per gallon
    Then It should prompt me to confirm the entered information with the total amount spent
    When I press 'n' to not confirm
    Then It should display 'Canceled'
