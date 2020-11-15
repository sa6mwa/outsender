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
highpass=f=80,\
equalizer=f=340:t=q:w=1:g=-3,\
equalizer=f=12000:t=q:w=2:g=3,\
compand=attacks=.0003:decays=.2:points=-90/-200|-70/-90|-60/-60|-30/-11|0/-3:soft-knee=6" \
"$OUT"
done

# afftdn=nt=w:nr=12
