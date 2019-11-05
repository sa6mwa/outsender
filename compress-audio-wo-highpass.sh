#!/bin/sh
set -e

ATTACK="0.000001"
DECAY="0.8"
ROUND="6"
SILENCE_BELOW="-30"
START_COMPRESS_AT="-18"
COMPRESS_TO="0"
GAIN="-1"
INITIAL_ASSUMED_LEVEL="${SILENCE_BELOW}"
ADJUSTER_DELAY="0.001"

# compand attack1,decay1 soft-knee-dB:in-dB1,in-dB2 gain initial_assumed_signal_level volume_adjuster_delay
# 2nd parameter, 4 means in-dB1,out-dB1,in-dB2,out-dB2
# 2nd parameter, 3 means in-dB1,in-dB2,out-dB2 (out-dB1 will be the same as in-dB1, no compression)
# 2nd parameter, 2 means in-dB1,in-dB2 (out-dBn will be the same as in-dBn)
COMPAND="${ATTACK},${DECAY} ${ROUND}:${SILENCE_BELOW},${SILENCE_BELOW},${START_COMPRESS_AT},${COMPRESS_TO} ${GAIN} ${INITIAL_ASSUMED_LEVEL} ${ADJUSTER_DELAY}"

if [ $# -lt 1 ]; then
  echo "Usage: $0 wavfile1.wav wavfile2.wav..."
  echo "Will produce compressed-wavfile1.wav, etc."
  echo "Assuming silence below ${SILENCE_BELOW} dB after normalization."
  exit 1
fi
for f in $*
do
  echo "$f: normalizing"
  sox --norm=-3 $f normalized-$f channels 1
  rm -f highpass-$f
  echo "$f: applying compression"
  sox normalized-$f compressed-$f compand $COMPAND
  rm -f normalized-$f
done
