#!/bin/bash
FPS=25
if [ $# -lt 1 ]; then
  echo "usage: $0 output_file_name[.mkv]"
  exit 1
fi

rec -c 1 -b 16 -r 44100 $1.wav &

# -video_size 1364x766
# ffmpeg -report
/usr/bin/ffmpeg \
-f x11grab -framerate 25 -video_size 1366x768 \
-i :0+0,0 -pix_fmt yuv420p \
-c:v libx264 \
-preset veryfast \
-crf 20 \
-s 1366x768 \
$1.mkv
pkill --signal SIGINT -P $$
wait $$
