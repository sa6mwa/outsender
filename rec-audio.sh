#!/bin/bash
if [ $# -lt 1 ]; then
  echo "usage: $0 prefix"
  echo "produces prefix.wav"
  echo "use pavucontrol to choose input source when recording multiple inputs"
  exit 1
fi
rec -c 1 -b 16 -r 44100 $1.wav
