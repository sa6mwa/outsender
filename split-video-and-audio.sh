#!/bin/sh
if [ $# -lt 1 ]; then
  echo "usage: $0 input.mp4 [input.avi] [etc.mov] ..."
  exit
fi
set -x
for f in $*
do
  ffmpeg -i "$f" -c:v libx264 -g 12 -bf 2 -crf 19 -preset superfast -tune fastdecode -map 0:a $f-audio.wav -map 0:v $f-video.mp4
done
