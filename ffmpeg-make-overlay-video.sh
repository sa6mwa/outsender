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
  ffmpeg -y -f lavfi \
  -i "color=color=red:size=640x360,format=yuva420p,geq=lum='p(X,Y)':a='if(lte(hypot(X-(W/2)+50,Y-(H/2)),H/2),255,0)'" \
  -i "$f" \
  -filter_complex "[0]alphaextract[a];[1]scale=640:360[b];[b][a]alphamerge" \
  -c:v png -pix_fmt yuva420p -an \
  "$OUT"
done
