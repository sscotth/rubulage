When /^the output should contain the following statistics:$/ do |table|
  table.hashes.each do |row|
      stat = row[:statistic].gsub(" ","\\s")
      step %(the output should match /#{stat}.*#{row[:value]}/)
  end
end
