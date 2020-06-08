#!/bin/bash
root=`pwd`"/"
raw_dir=$root"raw/records/"
data_dir=$root"data/"
threads=16

function mywget()
{
	filename=`echo "$1" | cut -d "/" -f7`
	wget -q --show-progress -O `pwd`"/raw/records/"$filename".html" $1
}
export -f mywget
xargs -P $threads -n 1 -I {} bash -c "mywget {}" < $data_dir"index.txt"