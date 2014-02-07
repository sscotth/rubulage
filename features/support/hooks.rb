require 'aruba'

Before do
  db = Rubulage::Database.connection
  db.execute('DELETE FROM transactions')
end
