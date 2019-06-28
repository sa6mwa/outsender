#!/bin/sh
mplayer -ontop -msglevel all=-1 -tv driver=v4l2:device=/dev/video0:width=200 tv://
