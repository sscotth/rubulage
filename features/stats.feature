Feature: Generic Stats Function
  As a car owner with a fuel receipt
  In order to understand my driving habits and costs
  I want to get various statistics about the receipts I have entered

  Background:
    Given the following transaction records
      | date      | odometer | price | gallons | missed | partial |
      | 2014-1-1  | 12345    | 1.009 | 12.5    | false  | false   |
      | 2014-1-2  | 12456    | 1.109 | 12.5    | false  | false   |
      | 2014-2-1  | 13456    | 1.209 | 13.5    | true   | false   |
      | 2014-3-1  | 14567    | 1.309 | 14.5    | false  | false   |
      | 2014-3-15 | 14678    | 1.409 | 5.5     | false  | true    |
      | 2014-4-1  | 15678    | 1.509 | 12.5    | false  | false   |

  Scenario: Proper Normal Entry
    When I successfully use the "stats" command
    Then the output should contain a table
    And the output should contain the following statistics:
      | statistic                                  | value |
      | Average Fuel per Fill-up                   | 11.83 |
      | Maximum Fuel per Fill-up                   | 14.5  |
      | Total Fuel                                 | 71.0  |
      | Average Fuel per Day                       | 0.79  |
      | Minimum MPG                                | 0.0   |
      | Average MPG                                | 46.94 |
      | Maximum MPG                                | 0.0   |
      | Minimum Price Paid                         | 1.009 |
      | Average Price Paid                         | 1.245 |
      | Maximum Price Paid                         | 1.509 |
      | Total Paid                                 | 88.38 |
      | Average Paid per Mile                      | 0.03  |
      | Average Paid per Day                       | 0.98  |
      | Average Miles Travelled between Fill-ups   | 0.0   |
      | Maximum Miles Travelled between Fill-ups   | 0.0   |
      | Total Miles Travelled                      | 88.38 |
      | Average Miles Travelled per Dollar of Fuel | 37.71 |
      | Average Miles Travelled per Day            | 37.05 |
      | Average Days between Fill-ups              | 14.99 |

    When I successfully use the "stats all" command
    Then the output should contain a table
    And the output should contain the following statistics:
      | statistic                                  | value |
      | Average Fuel per Fill-up                   | 11.83 |
      | Maximum Fuel per Fill-up                   | 14.5  |
      | Total Fuel                                 | 71.0  |
      | Average Fuel per Day                       | 0.79  |
      | Minimum MPG                                | 0.0   |
      | Average MPG                                | 46.94 |
      | Maximum MPG                                | 0.0   |
      | Minimum Price Paid                         | 1.009 |
      | Average Price Paid                         | 1.245 |
      | Maximum Price Paid                         | 1.509 |
      | Total Paid                                 | 88.38 |
      | Average Paid per Mile                      | 0.03  |
      | Average Paid per Day                       | 0.98  |
      | Average Miles Travelled between Fill-ups   | 0.0   |
      | Maximum Miles Travelled between Fill-ups   | 0.0   |
      | Total Miles Travelled                      | 88.38 |
      | Average Miles Travelled per Dollar of Fuel | 37.71 |
      | Average Miles Travelled per Day            | 37.05 |
      | Average Days between Fill-ups              | 14.99    |
