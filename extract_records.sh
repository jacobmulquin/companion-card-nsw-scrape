#!/bin/bash

data_file="data/records.csv"
echo "code;category;business_name;phone_number;address;postcode;website;description" > $data_file
current_dir=$(pwd)
current_dir+="/raw/records/"
filecount=$(ls -l $current_dir | wc -l)
i=1

for file in $current_dir*; do
  filename=${file%.html}
  echo $i:$filecount

 ((i=i+1))
 
  # code
  printf ${filename##*/} >> $data_file
  printf ";" >> $data_file

  # Category
  cat $file | hxnormalize -x | hxselect -ic "div.breadcrumbs li:last-of-type > a > span" | tr -s " " | tr -d '\n' >> $data_file
  printf ";" >> $data_file


  # Heading
  cat $file | hxnormalize -x  | hxselect -ic h1 | perl -MHTML::Entities -pe 'decode_entities($_);' | tr -s " " | tr -d '\n' >> $data_file
  printf ";" >> $data_file

  # Phone Number
  cat $file | hxnormalize -x | hxselect -ic "p:nth-of-type(3)" | tr -d '\n' | tr -s " " | tail -c 15 | grep -oP '\d+' | tr -d "\n"  >> $data_file
  cat $file | hxnormalize -x | hxselect -ic "p:nth-of-type(4)" | tr -d '\n' | tr -s " " | tail -c 15 | grep -oP '\d+' | tr -d "\n"  >> $data_file
  printf ";" >> $data_file

  # Address
  cat $file | hxnormalize -x | hxselect -ic ".card-address" | tr -d '\n' | tr -s " " | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' >> $data_file 
  printf ";" >> $data_file

  # Postcode
  cat $file | hxnormalize -x | hxselect -ic ".card-address" | tr -d '\n' | tr -s " " | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | tail -c 8 | grep -oP '\d+' | tr -d "\n" >> $data_file 
  printf ";" >> $data_file

  # Website
  cat $file | hxnormalize -x | hxselect -ic ".address-map" | hxwls | tr -d '\n' >> $data_file
  printf ";" >> $data_file

  # Description
  # Some pages have an empty <p> in front of the description :(
  cat $file | sed 's/<p><p>/<p>/g' | hxnormalize -x |  hxselect -ic "#readable-content > p:nth-of-type(1)" | tr -d '\n' | tr -s " " >> $data_file
  printf "\n" >> $data_file

 
  
done
echo $(pwd)"/"$data_file