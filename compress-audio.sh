#!/bin/sh
set -e

ATTACK="0.000001"
DECAY="0.8"
ROUND="6"
SILENCE_BELOW="-30"
GAIN="-1"
INITIAL_ASSUMED_LEVEL="${SILENCE_BELOW}"
ADJUSTER_DELAY="0.001"

# compand attack1,decay1 soft-knee-dB:in-dB1,out-dB1 gain initial_assumed_signal_level volume_adjuster_delay
COMPAND="${ATTACK},${DECAY} ${ROUND}:${SILENCE_BELOW},0 ${GAIN} ${INITIAL_ASSUMED_LEVEL} ${ADJUSTER_DELAY}"

if [ $# -lt 1 ]; then
  echo "Usage: $0 wavfile1.wav wavfile2.wav..."
  echo "Will produce compressed-wavfile1.wav, etc."
  echo "Assuming silence below ${SILENCE_BELOW} dB after normalization."
  exit 1
fi
for f in $*
do
  echo "$f: applying highpass filter"
  sox $f highpass-$f channels 1 gain -n -3 highpass 100
  echo "$f: normalizing"
  sox --norm=-1 highpass-$f normalized-$f
  rm -f highpass-$f
  echo "$f: applying compression"
  sox normalized-$f compressed-$f compand $COMPAND
  rm -f normalized-$f
done
