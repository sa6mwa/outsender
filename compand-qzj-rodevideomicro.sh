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
  OUT="companded-${bname%.*}.wav"
  ffmpeg -y -i "$f" -vn -ac 2 -filter_complex "\
pan=stereo|c0<.5*c0+.5*c1|c1<.5*c0+.5*c1,\
deesser,\
equalizer=f=90:t=o:w=1:g=2,\
equalizer=f=125:t=o:w=.5:g=3,\
equalizer=f=300:t=o:w=.5:g=-5,\
equalizer=f=325:t=o:w=.5:g=-4,\
equalizer=f=500:t=o:w=1:g=-6,\
equalizer=f=4500:t=o:w=2:g=-6,\
highpass=f=80,\
compand=attacks=.0001:decays=.3:points=-90/-900|-80/-90|-50/-50|-32/-6|0/-2|20/-2:soft-knee=12,\
alimiter=limit=0.7943282347242815:level=disabled" \
"$OUT"
done

# 0.7943282347242815 = -2 dB

## dB to fraction calculator
# http://www.sengpielaudio.com/calculator-db.htm

## fft denoise, not necessary with this mic/preamp combo
# afftdn=nt=w:nr=12

## octaves, center qrg
# 63 125 250 500 1000 2000 4000 8000 16000
## octaves, where the center qrg covers the low and high qrgs
# 20   - 31.5 - 45
# 45   - 63   - 90
# 90   - 125  - 175
# 175  - 250  - 350
# 350  - 500  - 700
# 700  - 1k   - 1.4k
# 1.4k - 2k   - 2.8k
# 2.8k - 4k   - 6k
# 6k   - 8k   - 12k
# 12k  - 16k  - 20k

