#!/bin/bash
# may need libavfilter-extra
if [ $# -lt 1 ]; then
  echo "usage: $0 input.wav [input.mp3] [input.aac] ..."
  exit
fi
set -x
for f in $*
do
  OUT="blended-$(basename $f).wav"
  ffmpeg -i "$f" -vn -filter_complex 'compand=attacks=.001:decays=.2:points=-90/-90|-48/-30|-30/-12|-12/-6|-6/-6|0/-3|20/-3:soft-knee=6' "$OUT"
done
