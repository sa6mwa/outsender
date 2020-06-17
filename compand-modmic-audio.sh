#!/bin/bash
# may need libavfilter-extra
#EXTRA="-tune fastdecode -filter_complex compand=attacks=.001:decays=.01:points=-90/-90|-45/-18|-12/-6|0/-3|20/0:soft-knee=6"
EXTRA="-filter_complex compand=attacks=.001:decays=.01:points=-90/-90|-60/-60|-45/-15|-12/-9|0/-6|20/-2:soft-knee=6"
if [ $# -lt 1 ]; then
  echo "usage: $0 input.wav [input.mp3] [input.aac] ..."
  exit
fi
for f in $*
do
  OUT="blended-$(basename $f).wav"
  set -x
  #ffmpeg -i "$f" -vn -filter_complex 'compand=attacks=.001:decays=.2:points=-90/-90|-60/-60|-45/-15|-12/-9|0/-6|20/-2:soft-knee=6' "$OUT"
  ffmpeg -i "$f" -vn -filter_complex 'compand=attacks=.001:decays=.2:points=-90/-90|-24/-18|-18/-9|-9/-6|-6/-6|0/-3|20/-3:soft-knee=6' "$OUT"
  set +x
done
