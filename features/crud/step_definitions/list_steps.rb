Given /^the following (.+) records?$/ do |factory, table|
  table.hashes.each do |hash|
    hash['date'] = Time.parse(hash['date'])
    record = Rubulage::Transactions.create!(hash)
    @id = record.id
  end
end


When /^I use the "list" command with an id$/ do
  step %(I successfully use the "list #{@id}" command)
end
