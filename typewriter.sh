#!/bin/bash

if [ $# -lt 1 ]; then
  echo "usage: $0 output_file_name[.mkv]"
  exit 1
fi

typewriter () {
  foo="$1"
  for (( i=0; i<${#foo}; i++ )); do
    echo -ne "${foo:$i:1}"
    sleep 0.10
  done
}

# $1-$(date +%y%m%d%H%M%S).mkv
/usr/bin/ffmpeg -loglevel 8 \
-f x11grab -framerate 25 -video_size 1366x768 \
-i :0+0,0+nomouse -pix_fmt yuv420p \
-c:v libx264 \
-preset fast \
-s 1366x768 \
$1.mkv &

clear
input=$(</dev/stdin)

#typewriter '    HELLO WORLD'
#input=$(</dev/stdin)

pkill -P $$
