#!/bin/bash

CRF=16
PRESET=ultrafast
GOP=12
BF=2

set -x
for f in $*
do
  bname="$(basename $f)"
  VOUT="blended-${bname%.*}.mp4"
  AOUT="blended-${bname%.*}.wav"
  ffmpeg -y -i "$f" \
  -r 25 \
  -pix_fmt yuv420p \
  -c:v libx264 -preset $PRESET -profile:v high -g $GOP -bf $BF -crf $CRF \
  -tune fastdecode -video_track_timescale 25000 \
  -map 0:v -an "$VOUT" \
  -map 0:a -vn "$AOUT"
done
