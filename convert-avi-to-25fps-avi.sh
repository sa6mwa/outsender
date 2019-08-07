#!/bin/bash
if [ $# -lt 1 ]; then
  echo "usage: $0 input1.avi input2.avi ..."
  echo "will produce 25fps-input1.avi and 25fps-input2.avi, etc"
  echo "do not use with h264/mp4, use other script for that"
  exit
fi
for f in $*
do
  set -x
  ffmpeg -i "$f" -codec copy -r 25 "25fps-$f"
  set +x
done
