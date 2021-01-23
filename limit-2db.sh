#!/bin/bash
# may need libavfilter-extra
if [ $# -lt 1 ]; then
  echo "Usage: $0 input.wav [input.mp3] [input.aac] ..."
  echo ""
  echo "The settings should allow you to have a background stereo track (like music)"
  echo "below -10 dB. Minus 10.01 dB in fraction is 0.3158639048423471 or 0.31586 if"
  echo "you can not fit all figures, this should produce a mix without clipping, just"
  echo "make sure you lower the music to this fraction when the vocal track is on."
  exit
fi
set -x
for f in $*
do
  bname="$(basename $f)"
  OUT="limited2db-${bname%.*}.wav"
  ffmpeg -y -i "$f" -vn -ac 2 -filter_complex "\
alimiter=limit=0.7943282347242815:level=disabled" \
"$OUT"
done

# 0.7943282347242815 = -2 dB

## dB to fraction calculator
# http://www.sengpielaudio.com/calculator-db.htm
