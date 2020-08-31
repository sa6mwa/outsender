#!/bin/bash
FPS=25
#CRF 23 is the default, 17 is visually lossless, -6 is double the bitrate
CRF=19
# medium (default), fast, faster, veryfaster, superfast, ultrafast
PRESET=superfast
GOP=12
BF=2
if [ $# -lt 1 ]; then
  echo "usage: $0 input1.avi input2.mts ..."
  echo "will produce ${FPS}fps-input1.mp4 and ${FPS}fps-input2.mp4"
  echo "in the current directory"
  exit
fi
for f in $*
do
  bname="$(basename $f)"
  OUT="${FPS}fps-${bname%.*}.mp4"
  set -x
  ffmpeg -i "$f" -r $FPS \
  -pix_fmt yuv420p -colorspace bt709 -color_trc bt709 -color_primaries bt709 \
  -color_range tv \
  -c:v libx264 \
  -preset $PRESET \
  -profile:v high \
  -g $GOP \
  -bf $BF \
  -an \
  -crf $CRF \
  -tune fastdecode \
  "$OUT"
  set +x
done
