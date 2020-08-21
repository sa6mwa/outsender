#!/bin/bash -e
FPS=25
DESKTOPAUDIODEV="alsa_output.pci-0000_00_1b.0.analog-stereo.monitor"
MICROPHONEDEV="alsa_input.usb-0d8c_C-Media_USB_Headphone_Set-00.analog-mono"

if [ $# -lt 1 ]; then
  echo "usage: $0 output_file_name[.mkv]"
  echo "check inside $0 for audio input devices."
  echo "eq and companding filter is for a ModMic UNI."
  exit 1
fi
## may be useful...
# sudo systemctl stop thermald

ffmpeg \
-thread_queue_size 64 -f x11grab -framerate $FPS -video_size 1366x768 -i :0+0,0 \
-f pulse -i "$DESKTOPAUDIODEV" \
-f pulse -i "$MICROPHONEDEV" \
-filter_complex "\
[1:a]aresample=async=1000[outa1];
[2:a]highpass=f=80,\
equalizer=f=8000:t=q:w=1:g=+12,\
equalizer=f=200:t=q:w=1:g=-6,\
compand=attacks=.001:decays=.1:points=-90/-90|-24/-12|-12/-6|-6/-3|-3/-3/0/-3|20/-3:soft-knee=6,\
aresample=async=1000[outa2]" \
-preset superfast \
-crf 23 \
-pix_fmt yuv420p \
-s 1366x768 \
-map 0:v -map '[outa1]' -map '[outa2]' \
-c:v libx264 \
-c:a:0 libmp3lame -ac:a:0 2 -ar:a:0 44100 -b:a:0 128k \
-c:a:1 libmp3lame -ac:a:1 1 -ar:a:1 44100 -b:a:1 128k \
$1.mkv
ffmpeg -i $1.mkv -map 0:2 -c:a copy $1.mp3
