require 'net/http'
require 'json'
require 'uk_postcode'

started = Time.now

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
    places.puts "#{{ index: { _index: 'geo', _type: 'place', _id: "#{values[0]}, #{values[12]}" } }.to_json}"
    places.puts "#{{ name: [values[0], values[12]], longitude: values[4].to_f, latitude: values[5].to_f }.to_json}"
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
    formatted_postcode = UKPostcode.new(values[0]).norm
    postcodes.puts "#{{ index: { _index: 'geo', _type: 'postcode', _id: "#{formatted_postcode}" } }.to_json}"
    postcodes.puts "#{{ name: [formatted_postcode, values[0]], longitude: values[1].to_f, latitude: values[2].to_f, formatted_name: formatted_postcode }.to_json}"
  end
end
postcodes.close
puts '  Done.'

print 'Splitting postcode into bitesize chunks.'
system("split -l 50000 data/postcodes.json zz")
puts '  Done.'

total_files = Dir.glob('zz*').select { |f| File.file?(f) }.count
count = 0
puts 'Posting postcodes.'
Dir.glob('zz*') do |f|
  count += 1
  print "Posting #{count} of #{total_files}."
  system("curl -s -XPOST localhost:9200/_bulk --data-binary @#{f} > /dev/null")
  puts '  Done.'
end

print 'Cleaning up.'
system("rm zz*")
puts '  Done'

puts ''
total_time = Time.now - started
mins, seconds = total_time.divmod(60)
puts "Time taken: #{mins} minutes & #{seconds} seconds."
