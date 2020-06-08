#!/bin/bash
root=`pwd`"/"
raw=$root"raw/"

mkdir -p $root"raw"
mkdir -p $root"raw/index"
mkdir -p $root"raw/records"
mkdir -p $root"output"
mkdir -p $root"data"

./dl_postcodes.sh
./extract_postcodes.sh
./dl_index.sh
./extract_index.sh
./dl_records.sh
./extract_records.sh
./output.php
