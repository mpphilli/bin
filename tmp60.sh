#!/bin/sh


/usr/bin/touch /data/tmp60/.st*
/usr/bin/find '/data/tmp60' -mtime +60 -print -delete &>> /tmp/tmp60.log

