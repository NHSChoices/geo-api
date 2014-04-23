require 'net/http'
require 'json'

print 'Remove existing index.'
system("curl -XDELETE localhost:9200/geo")
puts '  Done.'

# Places
print 'Importing places.'
File.delete('data/places.json') if File.exist?('data/places.json')
places = File.open("data/places.json", "w")
open("data/places.csv") do |csv|
  csv.each_line do |line|
    values = line.split(",")
    places.puts "#{{ index: { _index: 'geo', _type: 'postcode', _id: "#{values[0]}" } }.to_json}"
    places.puts "#{{ name: [values[0], values[12]], latitude: values[4].to_f, longitude: values[5].to_f }.to_json}"
  end
end
places.close
puts '  Done.'

print 'Posting places.'
system("curl -s -XPOST localhost:9200/_bulk --data-binary @./data/places.json > /dev/null")
puts '  Done.'
puts ''

print 'Importing postcodes.'
File.delete('data/postcodes.json') if File.exist?('data/postcodes.json')
postcodes = File.open('data/postcodes.json', "w")
open('data/postcodes.csv') do |csv|
  csv.each_line do |line|
    values = line.split(",")
    postcodes.puts "#{{ index: { _index: 'geo', _type: 'postcode', _id: "#{values[0]}" } }.to_json}"
    postcodes.puts "#{{ name: [values[0]], latitude: values[1].to_f, longitude: values[2].to_f }.to_json}"
  end
end
postcodes.close
puts '  Done.'

print 'Splitting postcode into bitesize chunks.'
system("split -l 20000 data/postcodes.json zz")
puts '  Done.'

puts 'Posting postcodes.'
Dir.glob('zz*') do |f|
  print "Posting #{f}."
  system("curl -s -XPOST localhost:9200/_bulk --data-binary @#{f} > /dev/null")
  puts '  Done.'
end

print 'Cleaning up.'
system("rm zz*")
puts '  Done'
