#!/bin/bash

APP_FILE=geo_api.god
APP_BASE=/var/apps/geoapi
LOG_FILE=${APP_BASE}/shared/god.log

# Load rbenv
if [ -f ~/.rbenvrc ]; then
  source ~/.rbenvrc
fi

# Check if god is in the path (ie, installed)
which god >/dev/null 2>&1
if [ $? -eq 0 ]; then
  # god is in the path - check if god is started
  god status >/dev/null 2>&1

  if [ $? -ne 0 ]; then
  # god isn't running - let's start it
    cd ${APP_BASE}/current/
    god -c ${APP_FILE} -l ${LOG_FILE}
  fi
fi 
