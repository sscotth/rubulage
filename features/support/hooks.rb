require 'aruba'

Before do
  db = Rubulage::Database.connection
  db.execute('DROP TABLE IF EXISTS transactions')
  db.execute('CREATE TABLE transactions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date DATETIME NOT NULL,
    odometer INTEGER NOT NULL,
    price INTEGER NOT NULL,
    gallons INTEGER NOT NULL,
    total INTEGER NOT NULL,
    missed TINYINT(1) NOT NULL DEFAULT 0,
    partial TINYINT(1) NOT NULL DEFAULT 0
  )')
end
