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
highpass=f=60,\
equalizer=f=350:t=q:w=2:g=-3,\
equalizer=f=4000:t=q:w=2:g=-6,\
equalizer=f=12000:t=q:w=2:g=+9,\
compand=attacks=.0003:decays=.1:points=-90/-90|-30/-9|-9/-6|-6/-6|0/-6|20/-6:soft-knee=6"  \
"$OUT"
done

# afftdn=nt=w:nr=12
