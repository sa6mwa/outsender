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
deesser,\
highpass=f=100,\
compand=attacks=.0003:decays=.2:points=-90/-900|-80/-90|-50/-50|-30/-11|0/-3|20/-3:soft-knee=3" \
"$OUT"
done

# afftdn=nt=w:nr=12
