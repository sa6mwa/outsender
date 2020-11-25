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
  ffmpeg -y -i "$f" -vn -ac 2 -filter_complex "\
pan=stereo|c0<.5*c0+.5*c1|c1<.5*c0+.5*c1,\
deesser,\
equalizer=f=250:t=o:w=1:g=-8,\
equalizer=f=500:t=o:w=1:g=-8,\
equalizer=f=1000:t=o:w=1:g=-7,\
equalizer=f=2000:t=o:w=1:g=-3,\
equalizer=f=4000:t=o:w=1:g=-6,\
equalizer=f=6000:t=o:w=.5:g=-6,\
highpass=f=100,\
lowpass=f=13000,\
compand=attacks=.0001:decays=.25:points=-90/-900|-80/-90|-50/-50|-36/-6|0/-1|20/-1:soft-knee=6,\
alimiter" \
"$OUT"
done

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

