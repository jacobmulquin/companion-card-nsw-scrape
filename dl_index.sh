#!/bin/bash

root=`pwd`"/"
raw_dir=$root"raw/"
out_dir=$raw_dir"index/"
pages=$raw_dir"pages.txt"
search_page="https://www.companioncard.nsw.gov.au/cardholders/where-can-i-use-my-card?result_536530_result_page="
threads=16
max_pages=`wget -O - -o /dev/null $search_page"1" | hxnormalize -x | hxselect -c "div.list-pagination > div:nth-of-type(2) > div > div:last-of-type > span" | tr -s " " | tr -d '\n'`

echo "Downloading index . . ."
echo "$max_pages pages in total"

echo "" > $pages
i=1
while [ "$i" -le "$max_pages" ]; do
	echo $i >> $pages
	i=$(($i + 1))
done

cat $pages | xargs -n 1 -P $threads -I {} wget -q --show-progress -O $out_dir{}.html $search_page{}