# Companion Card NSW Website Scraper

This set of scripts transforms the data available on the Companion Card NSW website
into a CSV and JSON files that have been categorised by Statistical Area Level 4.

## Tools Required

Linux
html-xml-utils
php

## Postcode/Region Information
Postcode data is gathered by Matthew Proctor: https://www.matthewproctor.com/australian_postcode

Note: This dataset appears to have some missing SA4 data, which means a few vaid postcodes are
categorised as "Unknown".

## Usage

Either run scrape.sh or do each step individually:

1. dl_postcodes.sh
2. extract_postcodes.sh
3. dl_index.sh
4. extract_index.sh
5. dl_records.sh
6. extract_records.sh
7. output.php