#!/bin/bash
#CRF 23 is the default, 17-18 is visually lossless, -6 is double the bitrate
CRF=19
# medium (default), fast, faster, veryfaster, superfast, ultrafast
PRESET=medium
GOP=12
BF=2
ABR=192k
OPTS="-profile:v high -crf $CRF -maxrate 10M -bufsize 12M \
-video_track_timescale 25000 -coder 1 -tune fastdecode \
-movflags +faststart \
-x264-params open-gop=0"

if [ $# -lt 1 ]; then
  echo "usage: $0 input1.avi input2.mts ..."
  echo "intended to render video taken with DJI Osmo Action for fast editing in Blender"
  echo "will produce blended-input1.mp4.mp4 and blended-input2.avi.mp4"
  echo "in the current directory"
  exit
fi
set -x
for f in $*
do
  bname="$(basename $f)"
  OUT="${bname%.*}-youtube.mp4"
  ffmpeg -y -i "$f" $OPTS \
  -pix_fmt yuv420p -colorspace bt709 -color_trc bt709 -color_primaries bt709 -color_range tv \
  -c:v libx264 -g $GOP -bf $BF -c:a libfdk_aac -profile:a aac_low -b:a $ABR \
  -preset $PRESET $EXTRA "$OUT"
done
