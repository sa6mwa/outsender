#!/bin/bash
# may need libavfilter-extra
#CRF 23 is the default, 17 is visually lossless, -6 is double the bitrate
CRF=17
# medium (default), fast, faster, veryfaster, superfast, ultrafast
PRESET=ultrafast
GOP=12
BF=2
ABR=384k
VF="hqdn3d"
## low light:
#VF="gamma=1.2:contrast=1.1,hqdn3d"
AFILTER="aresample=async=1,\
highpass=f=80,\
lowpass=f=12000,\
equalizer=f=90:t=o:w=1:g=1,\
equalizer=f=125:t=o:w=.5:g=1,\
equalizer=f=300:t=o:w=.5:g=-3,\
compand=attacks=.001:decays=.3:points=-90/-90|-48/-30|-30/-9|0/-3|20/-3:soft-knee=12,\
alimiter=limit=0.7943282347242815:level=disabled"
if [ $# -lt 1 ]; then
  echo "Usage: $0 input1.avi input2.mts ..."
  echo "Intended to transcode 1080p 25fps RockSteady video from DJI Osmo Action"
  echo "for fast editing in Blender."
  echo "Will produce blended-input1.mp4 in current directory."
  echo "Video is delayed 0.12 seconds (3 frames of 25) from audio (syncfix)."
  exit
fi
set -x
for f in $*
do
  ## itsoffset of 0.08 == 2 frames at 25 fps, 0.04 == 1 frame
  bname="$(basename $f)"
  OUT="blended-${bname%.*}.mkv"
  ffmpeg -y -i "$f" -itsoffset 0.08 -i "$f" -map 0:a -map 1:v \
  -r 25 \
  -pix_fmt yuv420p -colorspace bt709 -color_trc bt709 -color_primaries bt709 \
  -color_range tv \
  -vf "$VF" -c:v libx264 -preset $PRESET -profile:v high -g $GOP -bf $BF -crf $CRF \
  -filter_complex "$AFILTER" \
  -c:a pcm_s16le \
  -tune fastdecode -video_track_timescale 25000 \
  "$OUT"
done
#-c:a libfdk_aac -profile:a aac_low -b:a $ABR

## older filter_complex
#highpass=f=80,\
#lowpass=f=12000,\
#equalizer=f=90:t=o:w=1:g=2,\
#equalizer=f=125:t=o:w=.5:g=3,\
#equalizer=f=300:t=o:w=.5:g=-5,\
#equalizer=f=325:t=o:w=.5:g=-4,\
