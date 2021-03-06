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
  ffmpeg -i "$f" -vn -ac 2 -filter_complex "\
pan=stereo|c0<.5*c0+.5*c1|c1<.5*c0+.5*c1,\
deesser,\
highpass=f=80,\
compand=attacks=.0001:decays=.2:points=-90/-900|-80/-90|-50/-50|-30/-9|-2/-2|0/-2|20/-2:soft-knee=3" \
"$OUT"
done
