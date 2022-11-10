#!/bin/bash
set -euo pipefail
#CRF 23 is the default, 17 i visually lossless
CRF=17
PRESET=ultrafast
GOP=12
BF=2
if [ $# -lt 1 ]; then
  echo "Usage: $0 obs.mkv [obs2.mkv...]"
  echo "For converting OBS recordings to 25 fps with separate video and audio files"
  echo "with some audio filtering."
  exit
fi
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
volume=+3dB,\
alimiter=limit=0.7943282347242815:level=disabled[aout]" \
  -map 0:v -an "$VOUT" \
  -map "[aout]" -vn "$AOUT"
done
