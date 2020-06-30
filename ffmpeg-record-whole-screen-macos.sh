#!/bin/bash
FPS=25
if [ $# -lt 1 ]; then
  echo "usage: $0 output_file_name[.mkv]"
  exit 1
fi
# -video_size 1364x766
# ffmpeg -report
/usr/local/bin/ffmpeg \
-f avfoundation -i 1:0 -framerate $FPS -video_size 1920x1080 \
-pix_fmt yuv420p \
-c:v libx264 \
-an \
-preset faster \
-crf 17 \
-s 1920x1080 \
$1.mkv
