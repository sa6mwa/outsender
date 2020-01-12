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

twra () {
  COLUMNS=$(tput cols)
  foo="$1"
  let MOVE=${COLUMNS}-${#foo}
  printf '\n\e[%sG' ${MOVE}
  for (( i=0; i<${#foo}; i++ )); do
    echo -n "${foo:$i:1}"
    sleep 0.10
  done
}

mvBottomRight () {
  LINES=$(tput lines)
  COLUMNS=$(tput cols)
  printf '\e[%s;%sH' $LINES $COLUMNS
}

twraFile () {
  while read -u 3 l; do
    twra "$l"
    input=$(</dev/stdin)
  done 3<$1
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
mvBottomRight
input=$(</dev/stdin)

twraFile LICENSE

#typewriter '    HELLO WORLD'
#input=$(</dev/stdin)

pkill -P $$
