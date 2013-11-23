#!/bin/sh
# Uses the -U $DBUSER -h $DBHOST -d $DBNAME environment variables.

(
  # \COPY opendata_projects FROM PSTDIN WITH CSV HEADER
  cat 04-open_data-projects.csv | grep -e "^[0-9a-f]\{32\}"
  echo '\.'

  # \COPY opendata_resources FROM PSTDIN WITH CSV HEADER
  cat 05-open_data-resources.csv | grep -e "^[0-9a-f]\{32\}"
  echo '\.'

  # \COPY opendata_essays FROM PSTDIN WITH CSV HEADER
  cat 02-open_data-essays.csv | grep -e "^[0-9a-f]\{32\}"
  echo '\.'

  # \COPY opendata_donations FROM PSTDIN WITH CSV HEADER
  cat 01-open_data-donations.csv | grep -e "^[0-9a-f]\{32\}" | awk '!a[$1]++'
  echo '\.'

  # \COPY opendata_giftcards FROM PSTDIN WITH CSV HEADER
  cat 03-open_data-giftcards.csv | grep -e "^[0-9a-f]\{32\}" | awk '!a[$1]++'
  echo '\.'
) \
| psql -U $DBUSER -h $DBHOST -d $DBNAME -f donorschoose-org.sql
