split -l 1000 data/places.json zz

url=$1

curl -s -XPOST $url --data-binary @zzaa
