#!/bin/bash
if [ $# -lt 2 ]; then
  echo "usage: $0 split-video-1.avi split-video-2.avi ..."
  echo "will produce concat-split-video-1.avi"
  exit
fi
concatline='concat:'
for f in $*
do
  concatline="$concatline$f|"
  echo $f
done
concatline="${concatline:0:-1}"
set -x
ffmpeg -i "$concatline" -codec copy concat-$1
