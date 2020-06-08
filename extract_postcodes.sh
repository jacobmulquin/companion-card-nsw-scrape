#!/bin/bash

root=`pwd`"/"
rawdir=$root"raw/"
rawfile=$rawdir"postcodes.csv"
outfile=$root"data/postcodes.csv"

cut -d ',' -f 2,13 $rawfile | tr -d '"' | uniq  > $outfile 
#| grep -v ',$'
