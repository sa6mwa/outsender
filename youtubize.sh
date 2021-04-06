#!/bin/bash
#CRF 23 is the default, 17-18 is visually lossless, -6 is double the bitrate
CRF=19
# medium (default), fast, faster, veryfaster, superfast, ultrafast
PRESET=medium
GOP=12
BF=2
ABR=384k

if [ $# -lt 1 ]; then
  echo "usage: $0 input ..."
  echo "Intended to take a matroska mkv from Blender to publish on YouTube."
  echo "Assumes 25 fps."
  echo ""
  echo "Wait for stable file size was added to start youtubization as soon as Blender"
  echo "has finished rendering the pre-master matroska mkv. Usage example is to"
  echo "start rendering in Blender, start this script on the (growing) mkv file"
  echo "and have the computer automatically power down when done..."
  echo "example: $0 file-being-rendered.mkv ; poweroff"
  exit
fi
for f in $*
do
  prevfs=$(stat --printf="%s" $f)
  count=5
  echo "Waiting until $f has the same file size for at least 10 seconds before continuing..."
  while (( count >= 0 )) ; do
    sleep 2
    fs=$(stat --printf="%s" $f)
    if (( fs == prevfs )) ; then
      (( --count ))
    else
      count=5
    fi
    (( prevfs = fs ))
  done
  set -x
  bname="$(basename $f)"
  OUT="${bname%.*}-youtube.mp4"
  ffmpeg -y -i "$f" -r 25 \
  -pix_fmt yuv420p \
  -colorspace bt709 -color_trc bt709 -color_primaries bt709 -color_range tv \
  -c:v libx264 -profile:v high -crf $CRF -g $GOP -bf $BF \
  -preset $PRESET \
  -coder 1 -movflags +faststart -x264-params open-gop=0 \
  -c:a libfdk_aac -profile:a aac_low -b:a $ABR \
  "$OUT"
  set +x
done
