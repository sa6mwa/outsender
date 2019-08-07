#!/bin/bash
if [ $# -lt 1 ]; then
  echo "usage: $0 input1.mp4 input2.mp4 ..."
  echo "will produce 25fps-input1.mp4 and 25fps-input2.mp4, etc"
  exit
fi
for f in $*
do
  # -crf 17 = visually lossless, -6 = double the bitrate
  set -x
  ffmpeg -i "$f" -r 25 -c:v libx264 -c:a copy -crf 11 -preset medium -tune fastdecode "25fps-$f"
  set +x
done
