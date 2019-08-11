#!/bin/bash
FPS=25
if [ $# -lt 1 ]; then
  echo "usage: $0 output_file_name[.mkv]"
  exit 1
fi

# -video_size 1364x766
## center with two pillar boxes:
# -filter:v 'pad=ih*16/9:ih:(ow-iw)/2:(oh-ih)/2'
## left justify 4:3 video, one pillar box at right
# -filter:v 'pad=ih*16/9:ih:0:(oh-ih)'

/usr/bin/ffmpeg \
-f x11grab -framerate $FPS -video_size 1024x768 \
-i :0+0,0 -pix_fmt yuv420p \
-c:v libx264 \
-preset faster \
-filter:v 'pad=ih*16/9:ih:(ow-iw)/2:(oh-ih)/2' \
-s 1366x768 \
$1.mkv
