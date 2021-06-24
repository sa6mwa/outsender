#!/bin/bash
set -uo pipefail

if [ $# -lt 1 ]; then
  echo "usage: $0 file-to-wait-for"
  exit 1
fi

for f in $@ ; do
  prevfs=$(stat --printf="%s" $f)
  count=5
  echo "Waiting until $f has the same file size for at least 10 seconds before exiting..."
  while (( count > 0 )) ; do
    sleep 2
    fs=$(stat --printf="%s" $f)
    if (( fs == prevfs )) ; then
      (( --count ))
    else
      count=5
    fi
    (( prevfs = fs ))
  done
done
