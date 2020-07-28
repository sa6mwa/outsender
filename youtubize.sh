#!/bin/bash
#CRF 23 is the default, 17-18 is visually lossless, -6 is double the bitrate
CRF=20
# medium (default), fast, faster, veryfaster, superfast, ultrafast
PRESET=slow
GOP=12
BF=2
ABR=384k

if [ $# -lt 1 ]; then
  echo "usage: $0 input ..."
  echo "Intended to take a matroska mkv from Blender to publish on YouTube."
  echo "Assumes 25 fps."
  exit
fi
set -x
for f in $*
do
  bname="$(basename $f)"
  OUT="${bname%.*}-youtube.mp4"
  ffmpeg -y -i "$f" -r 25 \
  -pix_fmt yuv420p \
  -colorspace bt709 -color_trc bt709 -color_primaries bt709 -color_range tv \
  -c:v libx264 -profile:v high -crf 20 -g $GOP -bf $BF \
  -preset $PRESET \
  -coder 1 -movflags +faststart -x264-params open-gop=0 \
  -c:a libfdk_aac -profile:a aac_low -b:a $ABR \
  "$OUT"
done
