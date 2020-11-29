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
sudo vim /etc/modprobe.d/dslr-webcam.conf
```

Add the following to new file /etc/modprobe.d/dslr-webcam.conf:

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
again, connect your camera to via the USB port with the supplied USB cable
(there is a short USB cable supplied with the Nikon D5300 VR kit).

Before testing the camera, unmount the USB disk otherwise you won't be able to
capture video. Then...

```
gphoto2 --auto-detect
```

See if you can capture some video from the device...

```
gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0
```

The command above need to run in order to be able to capture anything from the
camera. The stream is available on `/dev/video0` which is what you use in OBS
Studio or any other streaming or capture software.

