Feature: Prefix matching
  As a client implementing autocomplete
  I want locations that match a given prefix
  So I can suggest completions to my users

  Scenario: Searching for a valid prefix
    When    I make a request for "/geo/lee"
    Then    I am returned locations that begin with "Lee"

  Scenario: Searching for a postcode without spaces
    When    I make a request for "/geo/ls116"
    Then    I am returned postcodes that begin with "LS11 6"

  Scenario: Searching for a postcode with spaces
    When    I make a request for "/geo/ls11+6"
    Then    I am returned postcodes that begin with "LS11 6"
