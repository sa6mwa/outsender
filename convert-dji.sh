#!/bin/bash
# may need libavfilter-extra
#CRF 23 is the default, 17 is visually lossless, -6 is double the bitrate
CRF=19
# medium (default), fast, faster, veryfaster, superfast, ultrafast
PRESET=superfast
GOP=50
BF=2
ABR=512k
EXTRA="-tune fastdecode -filter_complex compand=attacks=.001:decays=.01:points=-90/-90|-45/-21|-21/-12|0/-6|20/-3:soft-knee=6"
if [ $# -lt 1 ]; then
  echo "usage: $0 input1.avi input2.mts ..."
  echo "intended to render video taken with DJI Osmo Action for fast editing in Blender"
  echo "will produce blended-input1.mp4.mp4 and blended-input2.avi.mp4"
  echo "in the current directory"
  exit
fi
for f in $*
do
  OUT="blended-$(basename $f).mp4"
  set -x
  ffmpeg -i "$f" -c:v libx264 -g $GOP -bf $BF -c:a aac -b:a $ABR -crf $CRF -preset $PRESET $EXTRA "$OUT"
  set +x
done
