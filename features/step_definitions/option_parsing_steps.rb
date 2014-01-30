When /^I use the "([^"]*)" option$/ do |cmd|
  run_simple("rubulage #{unescape(cmd)}")
end

Then /^the exit status should report success$/ do
  assert_exit_status(0)
end

Then /^the banner "([^"]*)" should be present$/ do |expected_banner|
  %(the output should contain "#{expected_banner}")
end

Then /^the following options should be documented:$/ do |options|
  options.raw.each do |option|
    step %(the option "#{option[0]}" should be documented)
  end
end

Then /^the option "([^"]*)" should be documented(.*)$/ do |options,two|
  options.split(',').map(&:strip).each do |option|
    step %(the output should contain "#{option}")
  end
end
