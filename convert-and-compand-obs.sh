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
  -filter_complex "\
[0:a]highpass=f=80,\
equalizer=f=90:t=o:w=1:g=2,\
equalizer=f=125:t=o:w=.5:g=3,\
equalizer=f=300:t=o:w=.5:g=-5,\
equalizer=f=325:t=o:w=.5:g=-4,\
volume=+8dB,\
alimiter=limit=0.7943282347242815:level=disabled[aout]" \
  -map 0:v -an "$VOUT" \
  -map "[aout]" -vn "$AOUT"
done
