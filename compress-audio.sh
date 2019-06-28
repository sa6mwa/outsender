#!/bin/sh
#COMPAND="0.02,0.20 5:-60,-40,-10 -5 -90 0.1"
#COMPAND="0.3,5 6:-70,-60,-20 -10 -6 0.2"
#COMPAND="0.3,5 6:-70,-60,-10 -10 -6 0.2"
#COMPAND="0.001,5 6:-70,-60,-10 -10 -6 0.2"
COMPAND="0.00001,5 6:-70,-60,-3 -1 -6 0.2"
if [ $# -lt 1 ]; then
  echo "usage: $0 wavfile1.wav wavfile2.wav..."
  echo "will produce compressed-wavfile1.wav, etc"
  exit 1
fi
for f in $*
do
  echo "$f: applying highpass filter" &&
  sox $f highpass-$f gain -n -3 highpass 100 &&
  echo "$f: normalizing" &&
  sox --norm=-2 highpass-$f normalized-$f &&
  rm -f highpass-$f &&
  echo "$f: applying compression" &&
  sox normalized-$f compressed-$f compand $COMPAND &&
  rm -f normalized-$f
done
