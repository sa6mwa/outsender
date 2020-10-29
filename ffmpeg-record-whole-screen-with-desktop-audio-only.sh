#!/bin/bash -e
# pacmd list-sources
FPS=25
DESKTOPAUDIODEV="alsa_output.pci-0000_00_1b.0.analog-stereo.monitor"
#DESKTOPAUDIODEV="alsa_output.usb-0d8c_C-Media_USB_Headphone_Set-00.analog-stereo.monitor"
MICROPHONEDEV="alsa_input.usb-0d8c_C-Media_USB_Headphone_Set-00.analog-mono"
#MICROPHONEDEV="alsa_input.usb-USB_Microphone_USB_Microphone-00.analog-stereo"
#MICROPHONEDEV="alsa_input.usb-ZOOM_Corporation_H1_000000000000-00.analog-stereo"


if [ $# -lt 1 ]; then
  echo "usage: $0 output_file_name[.mkv]"
  echo "check inside $0 for audio input devices."
  echo "eq and companding filter is for a ModMic UNI."
  exit 1
fi
## may be useful...
# sudo systemctl stop thermald

ffmpeg \
-thread_queue_size 1024 -f x11grab -framerate $FPS -video_size 1366x768 -i :0+0,0 \
-f pulse -i "$DESKTOPAUDIODEV" \
-filter_complex "\
[1:a]aresample=async=1[outa]" \
-preset ultrafast \
-crf 23 \
-pix_fmt yuv420p \
-s 1366x768 \
-map 0:v -map '[outa]' \
-vsync 1 \
-c:v libx264 \
-c:a:0 pcm_s16le \
$1.mkv
#-c:a:0 libmp3lame -ac:a:0 2 -ar:a:0 44100 -b:a:0 128k \
#$1.mkv
