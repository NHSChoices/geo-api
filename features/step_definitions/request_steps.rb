When(/^I make a request for "(.*?)"$/) do |url|
  get GeoApi, url
end

Then(/^I am returned locations that begin with "(.*?)"$/) do |prefix|
  matched_locations.each { |match| expect(match).to match(/^#{prefix}/) }
end

Then(/^I am returned postcodes that begin with "(.*?)"$/) do |prefix|
  matched_locations.each { |match| expect(match).to match(/^#{prefix}/) }
end
