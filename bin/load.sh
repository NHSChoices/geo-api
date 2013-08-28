set -e

curl -XDELETE localhost:9200/geo

tail -n +2 data/places.csv |
  awk -F"," '{\
name = $2", "$5
key = tolower(name)
gsub(/[^a-zA-Z0-9]/, "_", key)
gsub(/_+/, "_", key)
lat  = $9
long = $8
print "{ \"index\" :  { \"_index\" : \"geo\", \"_type\" : \"place\", \"_id\" : \"" key "\" } }\
{ \"name\" : [\"" name "\"], \"latitude\" : "lat", \"longitude\" : " long " }" }' > data/places.json

curl -s -XPOST localhost:9200/_bulk --data-binary @data/places.json

tail -n +2 data/postcodes.csv |
  awk -F"," '{\
name = $1
key = toupper(name)
sub(" ", "", key)
without_spaces = name
gsub(" ", "", without_spaces)
lat  = $5
long = $6
print "{ \"index\" :  { \"_index\" : \"geo\", \"_type\" : \"postcode\", \"_id\" : \"" key "\" } }\
{ \"name\" : [\"" name "\", \"" without_spaces "\"], \"latitude\" : "lat", \"longitude\" : " long " }" }' > data/postcodes.json

split -l 200000 data/postcodes.json zz

for f in `ls zz*`; do
  curl -s -XPOST localhost:9200/_bulk --data-binary @$f
done

rm zz*

tail -n +2 data/postcode_outcodes.csv |
  awk -F"," '{\
name = $2
key = name
lat  = $3
long = $4
print "{ \"index\" :  { \"_index\" : \"geo\", \"_type\" : \"outcode\", \"_id\" : \"" key "\" } }\
{ \"name\" : [\"" name "\"], \"latitude\" : "lat", \"longitude\" : " long " }" }' > data/outcodes.json

curl -s -XPOST localhost:9200/_bulk --data-binary @data/outcodes.json
