#!/bin/bash
if [ $# -lt 1 ]; then
  echo "usage: $0 input1.mp4 input2.mp4 ..."
  echo "will produce 50fps-input1.mp4 and 50fps-input2.mp4, etc"
  exit
fi
for f in $*
do
  set -x
  ffmpeg -i "$f" -r 50 -c:v libx264 -c:a copy -crf 17 -preset veryfast -tune fastdecode "50fps-$f"
  set +x
done
