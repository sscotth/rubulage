# Rubulage

## What is this?

Like working in the command line? Want to know how much driving back and forth to work is costing you and the environment? Then this app is for you!

## Project Requirements

* Simple UX
* Persistent Relational Database CRUD
* Statistics Report
* Written in Ruby

## Feature List

* Entering information from gas receipts
  * Odometer
  * Price
  * Gallons
* Adjusting to missed fill-up
* Tracking multiple vehicles (SOON)
* Tracking multiple fuel types (SOON)

## Reports

* Tabular report with each fuel entry and its individual mileage
* Calculated Statistics
  * Minimum/Maximum/Quartile/Average MPG
  * Minimum/Maximum/Quartile/Average Fuel Price
  * Maximum/Average Volume
  * Maximum/Average Distance
  * Average $/mi, Mi/$, $/day, $/fill-up, Mi/fill-up, Days/fill-up
  * Total $ Spent
  * Total Gallons Used
  * [Carbon Footprint] [1] and [Offset Cost @ $10/tonne] [2]

## Data Source

User's receipts

## Model

### Transactions
  * id int PK AUTO
  * vehicle_id int
  * datetime datetime
  * odometer int(x1) e.g. (1234567 == 123,456.7)
  * pricepergallon int(x3) (e.g. 3459 == $3.459)
  * gallons int(x3) (e.g. 12345 == 12.345)
  * total int(x2) (e.g. 1234 == $12.34)
  * missed bit
  * partial bit

### Vehicles
  * id int PK AUTO
  * fuel_id int
  * desc string (e.g. 2001 Toyota Camry, Melissa's Honda, My Super Awesome Vespa)

### Fuel Types
  * id int PK AUTO
  * desc string (e.g. Diesel, E85, Unleaded with 10% Ethanol)
  * co2lbspergallon int (e.g. 1 (metric) tonne = 2204.62 lbs)

[1]: http://www.eia.gov/tools/faqs/faq.cfm?id=307&t=11
[2]: http://www.carbonfund.org/individuals
