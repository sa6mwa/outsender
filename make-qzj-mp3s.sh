#!/bin/sh
artist="SA6MWA"
album="QZJ"
track="1"
title="QZJ001 Utesändaren blir också en podcast"
genre="Podcast"
year="2020"
woar="https://patreon.com/outsender"
language="SWE"
comment="www.patreon.com/outsender"
coverfront="$HOME/podcast/artwork/qzj-1000x1000.jpeg"

if [ $# -lt 1 ]; then
  echo "usage: $0 podcast.wav [input.avi] [etc.mov] ..."
  exit
fi
set -x
for f in $*
do
  bname="$(basename $f)"
  for x in 192 256 320
  do
    OUT="${bname%.*}-${x}kb.mp3"
    lame -b ${x} \
      --tt "${title}" \
      --ta "${artist}" \
      --tl "${album}" \
      --ty "${year}" \
      --tc "${comment}" \
      --tn "${track}" \
      --tg "${genre}" \
      --ti "${coverfront}" \
      --tv TLAN="${language}" \
      --tv WOAR="${woar}" \
      --add-id3v2 \
      "${f}" "${OUT}"
  done
done
