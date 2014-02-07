Given /^the following (.+) records?$/ do |factory, table|
  table.hashes.each do |hash|
    hash['date'] = Time.parse(hash['date'])
    Rubulage::Transactions.create!(hash)
  end
end
