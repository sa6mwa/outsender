#!/bin/bash
if [ $# -lt 2 ]; then
  echo "usage: $0 split-video-1.mp4 split-video-2.mp4 ..."
  echo "will produce concat-split-video-1.mp4"
  exit
fi
tmpfile=$(mktemp ./mp4concat.XXXXXX)
trap "rm -f $tmpfile" 0 2 3 15
for f in $*
do
  echo "file $f" >> $tmpfile
  echo $f
done
set -x
ffmpeg -f concat -safe 0 -i $tmpfile -c copy concat-$1
