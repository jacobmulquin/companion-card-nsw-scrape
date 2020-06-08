#!/bin/bash
root=`pwd`"/"
raw_dir=$root"raw/index/"
data_dir=$root"data/"

for file in $raw_dir*;
do
  cat $file | hxnormalize -x | hxselect -i "span[id*=result-]" | hxwls >> $data_dir"index.txt"
done