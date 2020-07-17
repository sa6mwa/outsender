#!/bin/bash
FPS=25
#CRF 23 is the default, 17 is visually lossless, -6 is double the bitrate
CRF=19
# medium (default), fast, faster, veryfaster, superfast, ultrafast
PRESET=superfast
GOP=12
BF=2
EXTRA="-tune fastdecode"
if [ $# -lt 1 ]; then
  echo "usage: $0 input1.avi input2.mts ..."
  echo "will produce ${FPS}fps-slomo-input1.avi.mp4 and ${FPS}fps-slomo-input2.mts.mp4"
  echo "in the current directory"
  exit
fi
for f in $*
do
  OUTPUT="${FPS}fps-slomo-$(basename $f).mp4"
  set -x
  ffmpeg -i "$f" -vf setpts=4*PTS -r $FPS -c:v libx264 -g $GOP -bf $BF -an -crf $CRF -preset $PRESET $EXTRA "${OUTPUT}"
  set +x
done
