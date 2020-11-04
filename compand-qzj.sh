#!/bin/bash
# may need libavfilter-extra
if [ $# -lt 1 ]; then
  echo "usage: $0 input.wav [input.mp3] [input.aac] ..."
  exit
fi
set -x
for f in $*
do
  bname="$(basename $f)"
  OUT="companded-${bname%.*}.wav"
  ffmpeg -i "$f" -vn -ac 1 -filter_complex "\
highpass=f=100,\
compand=attacks=.0005:decays=.1:points=-90/-90|-27/-9|-9/-6|-6/-3|-3/-3|0/-3|20/-3:soft-knee=6" \
"$OUT"
done
