#!/bin/bash
DELAY=0.05

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

twraColor () {
  COLUMNS=$(tput cols)
  foo="$1"
  # color is what follows the escape sequency without m.
  # for example: 1;37 will print the line in bright white
  # 0 will reset any color (default)
  color="$2"
  if [ "$color" = "" ]; then
    color="0"
  fi
  let MOVE=${COLUMNS}-${#foo}
  printf '\n\e[%sG\e[%sm' ${MOVE} $color
  for (( i=0; i<${#foo}; i++ )); do
    echo -n "${foo:$i:1}"
    sleep 0.10
  done
}

twca () {
  COLUMNS=$(tput cols)
  foo="$1"
  let MOVE=(${COLUMNS}-${#foo})/2+1
  printf '\n\e[%sG' ${MOVE}
  for (( i=0; i<${#foo}; i++ )); do
    echo -ne "${foo:$i:1}"
    sleep $DELAY
  done
}

twcaFileOneParaPerScreen () {
  ROWS=$(tput lines)
  lc=0
  PARA=""
  while read -u 3 l; do
    if [ ${#l} -lt 1 ]; then
      clear
      let MOVE=(${ROWS}-${lc})/2-1
      printf '\e[%sB' ${MOVE}
      while IFS= read -r line; do
        if [ ${#line} -gt 0 ]; then
          twca "$line"
        fi
      done <<< "$PARA"
      PARA=""
      lc=0
      input=$(</dev/stdin)
    else
      PARA="${PARA}${l}"$'\n'
      let lc=${lc}+1
    fi
  done 3<$1
  if [ $lc -gt 0 ]; then
    clear
    let MOVE=(${ROWS}-${lc})/2-1
    printf '\e[%sB' ${MOVE}
    while IFS= read -r line; do
      if [ ${#line} -gt 0 ]; then
        twca "$line"
      fi
    done <<< "$PARA"
    input=$(</dev/stdin)
  fi
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

twraFileColor () {
  evencolor="0"
  oddcolor="1;33"
  color="$evencolor"
  c=0
  while read -u 3 l; do
    if [ $c -lt 1 ]; then
      color="$evencolor"
      let c=$c+1
    else
      color="$oddcolor"
      c=0
    fi
    twraColor "$l" "$color"
    input=$(</dev/stdin)
  done 3<$1
}

# $1-$(date +%y%m%d%H%M%S).mkv
# 1366x768
/usr/bin/ffmpeg -loglevel 8 \
-f x11grab -framerate 25 -video_size 1024x768 \
-i :0+0,0+nomouse -pix_fmt yuv420p \
-c:v libx264 \
-preset faster \
-crf 19 \
-s 1024x768 \
$1.mkv &



clear
input=$(</dev/stdin)
twcaFileOneParaPerScreen credz

#input=$(</dev/stdin)

pkill -P $$
