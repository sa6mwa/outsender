#!/bin/bash
FPS=25
#CRF 23 is the default, 17 is visually lossless, -6 is double the bitrate
CRF=10
# medium (default), fast, faster, veryfaster, superfast, ultrafast
PRESET=superfast
GOP=12
BF=2
EXTRA="-tune fastdecode"
if [ $# -lt 1 ]; then
  echo "usage: $0 input1.avi input2.mts ..."
  echo "will produce ${FPS}fps-input1.mkv and ${FPS}fps-input2.mkv"
  echo "in the current directory"
  exit
fi
for f in $*
do
  bname="$(basename $f)"
  OUT="${FPS}fps-${bname%.*}.mkv"
  set -x
  ffmpeg -i "$f" -r $FPS -c:v libx264 -g $GOP -bf $BF -crf $CRF -c:a pcm_s16le -preset $PRESET $EXTRA "$OUT"
  set +x
done
