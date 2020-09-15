#!/bin/bash
if [ $# -lt 1 ]; then
  echo "Usage: $0 input1.mp4 input2.mts ..."
  echo "Will produce input1-overlay.mov in current directory."
  exit
fi
set -x
for f in $*
do
  bname="$(basename $f)"
  OUT="${bname%.*}-overlay.mov"
  ffmpeg -y \
  -i "$f" \
  -loop 1 \
  -i mask.png \
  -i greenborder.png \
  -filter_complex "[1]alphaextract[a];[0]scale=640:360[b];[b][a]alphamerge[bg];[bg][2]overlay=0:0" \
  -c:v png -pix_fmt rgba -an \
  "$OUT"
done
