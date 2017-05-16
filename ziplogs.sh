#!/bin/bash 
function Main {
  ROOT_UID=0     # Only users with $UID 0 have root privileges.
  E_XCD=86       # Can't change directory?
  E_NOTROOT=87   # Non-root exit error.

  LOG_DIR=/data/DockerProjects/Syslog-ng/var_log_syslog-ng

  # Run as root, of course.
  if [ "$UID" -ne "$ROOT_UID" ]
  then
    echo "Must be root to run this script."
    exit $E_NOTROOT
  fi  

  date 
  /usr/bin/find $LOG_DIR -type f -regex ".*[0-9][0-9]" -mtime +3 -execdir  /usr/bin/bzip2 -v '{}' \;
}
Main &>> /tmp/${${0:t}:r}.log

