#!/bin/bash
# may need libavfilter-extra
#CRF 23 is the default, 17 is visually lossless, -6 is double the bitrate
CRF=17
# medium (default), fast, faster, veryfaster, superfast, ultrafast
PRESET=ultrafast
GOP=12
BF=2
ABR=384k
VF="eq=saturation=1.65,curves=m='0/0 0.5/0.4 1/1',removegrain=4,hqdn3d=6"
# VF curves at sunset m='0/0 0.5/0.6 1/1'
AFILTER="aresample=async=1,\
equalizer=f=12500:width_type=h:width=2000:g=-12,\
equalizer=f=16000:width_type=h:width=3500:g=-12,\
equalizer=f=20000:width_type=h:width=4000:g=-36,\
compand=attacks=.001:decays=.2:points=-90/-90|-48/-30|-30/-12|-12/-6|-6/-6|0/-6|20/-6:soft-knee=6"
if [ $# -lt 1 ]; then
  echo "Usage: $0 input1.avi input2.mts ..."
  echo "Intended to transcode 1080p 25fps RockSteady video from DJI Osmo Action"
  echo "for fast editing in Blender."
  echo "Will produce blended-input1.mp4 in current directory."
  echo "Video is delayed 0.08 seconds (2 frames out of 25) from audio (syncfix)."
  exit
fi
set -x
for f in $*
do
  bname="$(basename $f)"
  OUT="blended-${bname%.*}.mp4"
  ffmpeg -y -i "$f" -itsoffset 0.08 -i "$f" -map 0:a -map 1:v \
  -r 25 \
  -pix_fmt yuv420p -colorspace bt709 -color_trc bt709 -color_primaries bt709 \
  -color_range tv \
  -vf "$VF" -c:v libx264 -preset $PRESET -profile:v high -g 12 -bf 2 -crf 17 \
  -filter_complex "$AFILTER" \
  -c:a libfdk_aac -profile:a aac_low -b:a $ABR \
  -tune fastdecode -video_track_timescale 25000 \
  "$OUT"
done
