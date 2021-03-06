#!/bin/bash
FPS=25
if [ $# -lt 1 ]; then
  echo "usage: $0 output_file_name[.mkv]"
  exit 1
fi

# -video_size 1364x766
# ffmpeg -report
#-f x11grab -framerate $FPS -video_size 1366x768
#-i :0+0,0 -pix_fmt yuv420p
#-s 1366x768
/usr/bin/ffmpeg \
-f x11grab -framerate $FPS -video_size 1920x1080 \
-i :0+0,0 -pix_fmt yuv420p \
-c:v libx264 \
-crf 20 \
-preset veryfast \
-s 1920x1080 \
$1.mkv
