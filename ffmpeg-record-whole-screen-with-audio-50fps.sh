#!/bin/bash
if [ $# -lt 1 ]; then
  echo "usage: $0 output_file_name[.mkv]"
  exit 1
fi

# start recording
# start pavucontrol
# choose ffmpeg (Lav something) and Monitor something instead of Internal Microphone

# -video_size 1364x766
/usr/bin/ffmpeg \
-f x11grab -framerate 50 -video_size 1366x768 \
-i :0+0,0 \
-f pulse -i default \
-preset faster \
-pix_fmt yuv420p \
-c:v libx264 \
-s 1366x768 \
$1.mkv
