#!/bin/bash
# may need libavfilter-extra
#CRF 23 is the default, 17 is visually lossless, -6 is double the bitrate
CRF=17
# medium (default), fast, faster, veryfaster, superfast, ultrafast
PRESET=ultrafast
GOP=12
BF=2
ABR=384k
#VF="hqdn3d"
VF="hqdn3d"
AFILTER="aresample=async=1,\
compand=attacks=.001:decays=.2:points=-90/-90|-48/-30|-30/-12|-12/-6|-6/-6|0/-3|20/-3:soft-knee=6"
if [ $# -lt 1 ]; then
  echo "Usage: $0 input1.avi input2.mts ..."
  echo "Intended to transcode 1080p 25fps RockSteady video from DJI Osmo Action"
  echo "for fast editing in Blender."
  echo "Will produce blended-input1.mp4 in current directory."
  exit
fi
set -x
for f in $*
do
  bname="$(basename $f)"
  OUT="blended-${bname%.*}.mkv"
  ffmpeg -y -i "$f" \
  -r 25 \
  -pix_fmt yuv420p -colorspace bt709 -color_trc bt709 -color_primaries bt709 \
  -color_range tv \
  -vf "$VF" -c:v libx264 -preset $PRESET -profile:v high -g $GOP -bf $BF -crf $CRF \
  -tune fastdecode -video_track_timescale 25000 \
  -c:a pcm_s16le \
  "$OUT"
done
