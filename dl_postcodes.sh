#!/bin/bash

root=`pwd`"/"
rawdir=$root"raw/"
outfile=$rawdir"postcodes.csv"

wget -q --show-progress -O $outfile https://github.com/matthewproctor/australianpostcodes/raw/master/australian_postcodes.csv