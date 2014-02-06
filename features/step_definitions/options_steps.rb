When /^I successfully use the "([^"]*)" (?:option|command|argument)?$/ do |cmd|
  run_simple("rubulage #{unescape(cmd)}")
  assert_exit_status(0)
end

When /^I use the "([^"]*)" (?:option|command|argument)?$/ do |cmd|
  run_simple("bundle exec rubulage #{unescape(cmd)}", fail_on_error=false)
end

Then /^the exit status should report success$/ do
  assert_exit_status(0)
end

Then /^the banner "([^"]*)" should be present$/ do |expected_banner|
  step %(the output should contain "#{expected_banner}")
end

Then /^the following options should be documented:$/ do |options|
  options.raw.each do |option|
    step %(the option "#{option[0]}" should be documented)
  end
end

Then /^the option "([^"]*)" should be documented$/ do |options|
  options.split(',').map(&:strip).each do |option|
    step %(the output should contain "#{option}")
  end
end
