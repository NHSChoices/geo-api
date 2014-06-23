# Geo Api

[![Build Status](https://travis-ci.org/NHSChoices/geo-api.png?branch=master)](https://travis-ci.org/NHSChoices/geo-api)
[![Code Climate](https://codeclimate.com/github/NHSChoices/geo-api.png)](https://codeclimate.com/github/NHSChoices/geo-api)
[![Coverage Status](https://coveralls.io/repos/NHSChoices/geo-api/badge.png)](https://coveralls.io/r/NHSChoices/geo-api)  
[![Dependency Status](https://gemnasium.com/NHSChoices/geo-api.png)](https://gemnasium.com/NHSChoices/geo-api)

Search for postcodes, outcodes and location names.

## Prerequisites ##

* Elastic Search

## Data load

Run `ruby ./bin/load.rb` with the extracted place tables in data.

## Environments 

### Integration
   [http://cplus-i-api.cloudapp.net/geo/ls1](http://cplus-i-api.cloudapp.net/geo/ls1)
### Staging
   [http://cplus-s-api.cloudapp.net/geo/ls1](http://cplus-s-api.cloudapp.net/geo/ls1)
### Production
   [http://cplus-p-api.cloudapp.net/geo/ls1](http://cplus-p-api.cloudapp.net/geo/ls1)
