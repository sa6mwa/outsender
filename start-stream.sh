#!/bin/sh
while true ; do
gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -colorspace bt709 -threads 0 -f v4l2 /dev/video0
sleep 5
done
