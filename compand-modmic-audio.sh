#!/bin/bash
# may need libavfilter-extra

FILTER="\
highpass=f=80,\
equalizer=f=8000:t=q:w=1:g=+12,\
equalizer=f=200:t=q:w=1:g=-6,\
compand=attacks=.001:decays=.1:points=-90/-90|-24/-6|-6/-3|-3/-3|0/-3|20/-3"

if [ $# -lt 1 ]; then
  echo "usage: $0 input.wav [input.mp3] [input.aac] ..."
  exit
fi
for f in $*
do
  bname="$(basename $f)"
  OUT="blended-${bname%.*}.wav"
  set -x
  ffmpeg -i "$f" -vn -filter_complex "$FILTER" "$OUT"
  set +x
done
