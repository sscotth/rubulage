@wip
Feature: Parse command line options
  As a car owner
  In order to efficiently use the app on the command line
  I want to pass values as options

  Scenario: Provide help
    When I use the "--help" option
    Then the exit status should report success
    Then the banner "Usage: rubulage [command] [options]" should be present
    And the following options should be documented:
      | --date    |
      | --odo     |
      | --id      |
      | --gal     |
      | --ppg     |
      | --missed  |
      | --partial |
      | --version |
