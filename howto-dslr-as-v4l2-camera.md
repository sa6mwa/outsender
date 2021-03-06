# DSLR as a V4L2 Video Capture Device in OBS Studio

I followed the instructions found on
<https://medium.com/nerdery/dslr-webcam-setup-for-linux-9b6d1b79ae22> and got
my Nikon D5300 working as a Video4Linux Version 2 (v4l2) Video Capture Device
for use in OBS Studio. I run Ubuntu Mate on the machine I wanted to use this
camera on and these instructions are tailored for that distribution.

## ffmpeg

You also need `ffmpeg`, but I prefer to roll my own to get the superior
`libfdk_aac` audio encoder as the built in aac encoder in ffmpeg produces clips
and other artifacts (which `fdk_aac` does not). In the repository
`miscellaneous` on <https://github.com/sa6mwa> you'll find the script under
`scripts/` or at
<https://github.com/sa6mwa/miscellaneous/blob/master/scripts/build-ffmpeg-with-libfdk-aac.sh>.

## tl;dr

```
sudo apt-get install gphoto2 v4l2loopback-utils v4l2loopback-dkms
echo 'alias dslr-webcam v4l2loopback' | sudo tee -a /etc/modprobe.d/dslr-webcam.conf
echo 'options v4l2loopback exclusive_caps=1 max_buffers=2' | sudo tee -a /etc/modprobe.d/dslr-webcam.conf
echo dslr-webcam | sudo tee -a /etc/modules
sudo modprobe dslr-webcam
gphoto2 --auto-detect
gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -colorspace bt709 -threads 0 -f v4l2 /dev/video0
```

## Step-by-step

```
sudo apt-get install gphoto2 v4l2loopback-utils v4l2loopback-dkms
sudo vim /etc/modprobe.d/dslr-webcam.conf
```

Add the following to new file `/etc/modprobe.d/dslr-webcam.conf`:

```
# exclusive_caps=1 enables exclusive capture mode, only CAPTURE/OUTPUT, which is what we want.
# max_buffers=2 is recommended in many examples, default is 32. No explanation
# is given anywhere why it should be 2, some suggest v4l2loopback suffers
# segmantation faults with the default value, other than that, no one offers a
# good explanation why they recommend 2.
alias dslr-webcam v4l2loopback
options v4l2loopback exclusive_caps=1 max_buffers=2
```

Save and exit. Continue...

```
sudo vim /etc/modules
```

Add `dslr-webcam` to the end of this file so that it looks something like this...

```
# /etc/modules: kernel modules to load at boot time.
#
# This file contains the names of kernel modules that should be loaded
# at boot time, one per line. Lines beginning with "#" are ignored.
dslr-webcam
```

Reboot to confirm this gets loaded at your next boot. When the machine is up
again, connect your camera via the USB port with the supplied USB cable (there
is a short USB cable supplied with the Nikon D5300 VR kit).

Before testing the camera, unmount the USB disk otherwise you won't be able to
capture video. Then...

```
$ gphoto2 --auto-detect
Model                          Port
----------------------------------------------------------
Nikon DSC D5300                usb:006,004
```

See if you can capture some video from the device...

```
gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -colorspace bt709 -threads 0 -f v4l2 /dev/video0
```

If you have multiple devices in the `--auto-detect` output you can specify which camera to use by it's port, e.g...

```
gphoto2 --stdout --capture-movie --port usb:006,004 | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -colorspace bt709 -threads 0 -f v4l2 /dev/video0
```

The command above need to run (in the background or in a separate
session/terminal) in order to be able to capture anything from the camera. The
stream is available on `/dev/video0` which is what you use in OBS Studio or any
other streaming or capture software as an input source. The pixel format and
the colorspace has been changed from the original mjpeg stream, if you don't
like that you see you can first remove `-colorspace bt709`, then `-pix_fmt
yuv420p`.  The streaming software will most likely output a format suitable for
your platform. `yuv420p` and `bt709` (RGB) is a common recommended format for
e.g YouTube.

## Caveat

The problem with the live view on Nikon cameras (or at least on the D5300) is
that the resolution is only 640x424 pixels. You can not get any higher
resolution than this. The reason is that the only image feed available from the
USB interface is the live view/preview feature in mjpeg format, not the actual
video feed. You need a HDMI to USB interface for higher resolution. 640x424
will be fine as webcam or as picture-in-picture for presentations or streaming.

## The mjpeg stream on Nikon D5300

The mjpeg streaming coming out of the live preview is 640x424, pix_fmt is
yuvj422p, and colorspace is bt470bg.  `color_primaries` is unknown. `bt470bg`
is PAL by the way, `smpte170m` is NTSC. You can see the details of the stream
using the following command...

```
gphoto2 --stdout --capture-movie | ffprobe -i - -v error -show_streams | less
```

## Extend the auto-off live preview timeout

Default live view timeout is 10 minutes. When the camera shuts off the stream
will temporarily stop. `gphoto2` seem to be able to wake up the camera again
and the stream continues, but it freezes for a couple of seconds. You can
extend the timeout to 30 minutes, but not turn it off entirely.  On the camera,
enter `Menu`, `Custom Settings Menu` (the pencil), `c Timers/AE lock`, `c2 Auto
off timers`, `Custom`, `Live view` (press the right arrow), choose `30 min`.
You should be able to prevent the live view from turning off after 30 minutes
by pressing something like the `+/-` exposure key near the shutter periodically
to reset the timer.
