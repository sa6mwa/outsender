#!/bin/bash
CRF=17
# medium (default), fast, faster, veryfaster, superfast, ultrafast
PRESET=ultrafast
GOP=12
BF=2
ABR=384k

if [ $# -lt 1 ]; then
  echo "usage: $0 audiofile"
  exit 1
fi

set -x
for f in $*
do
  bname="$(basename $f)"
  OUT="showspectrum-${bname%.*}.mkv"
  #ffmpeg -i "$f" -filter_complex "[0:a]showwaves=s=1280x100:mode=cline:rate=25:scale=sqrt,format=yuv420p[v]" -map "[v]" -map 0:a \
  ffmpeg -i "$f" -filter_complex "[0:a]showspectrum=s=1280x100:mode=combined:color=green:saturation=1:slide=1:scale=cbrt:legend=1,format=yuv420p[v]" -map "[v]" -map 0:a \
  -r 25 \
  -c:v libx264 -preset $PRESET -profile:v high -g $GOP -bf $BF -crf $CRF \
  -c:a pcm_s16le \
  -tune fastdecode -video_track_timescale 25000 \
  "$OUT"
done
