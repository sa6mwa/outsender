#!/bin/bash
FPS=25
#CRF 23 is the default, 17 is visually lossless, -6 is double the bitrate
CRF=10
# medium (default), fast, faster, veryfaster, superfast, ultrafast
PRESET=superfast
GOP=50
BF=2
ABR=160k
EXTRA="-tune fastdecode"
if [ $# -lt 1 ]; then
  echo "usage: $0 input1.avi input2.mts ..."
  echo "will produce ${FPS}fps-input1.avi.mp4 and ${FPS}fps-input2.mts.mp4"
  echo "in the current directory"
  exit
fi
for f in $*
do
  OUT="${FPS}fps-$(basename $f).mp4"
  set -x
  ffmpeg -i "$f" -r $FPS -c:v libx264 -g $GOP -bf $BF -c:a aac -b:a $ABR -crf $CRF -preset $PRESET $EXTRA "$OUT"
  set +x
done
