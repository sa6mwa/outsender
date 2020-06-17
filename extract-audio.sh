#!/bin/sh
if [ $# -lt 1 ]; then
  echo "usage: $0 input.mp4 [input.avi] [etc.mov] ..."
  exit
fi
set -x
for f in $*
do
  ffmpeg -i "$f" -vn "$f-audio.wav"
done
