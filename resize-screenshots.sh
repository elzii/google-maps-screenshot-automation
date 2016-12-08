#!/bin/bash

IN=$1
OUT=$(echo $1 | sed 's/^\(.*\)\.[a-zA-Z0-9]*$/\1/')
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# return if file does not exist
if [[ ! -f $IN ]] ; then
  echo "File: $IN does not exist."
  exit
fi


mogrify \
  -format jpg \
  -verbose \
  -resize 2000x2000^ \
  -quality 80 \
  -gravity center \
  -extent 2000x2000 \
  -path $DIR ./src/*.png

