#!/bin/zsh
# vim:softtabstop=3:shiftwidth=3:expandtab:foldmethod=indent:number 
#setopt XTRACE 

function MAIN() {
   SAVEIFS=$IFS
   IFS=$(echo -en "\n\b")

   # find video files to move
   for FILE in `find . -size +100M -type f `
   do
      COPYFILES  "$FILE"
   done

   DELETEFILES
   if [[ -n $strActive ]] ; then
      echo -e " Finished -- `date`"
      echo -e "**************************************************"
   fi
   IFS=$SAVEIFS
}


function COPYFILES() {
   # if file exists and file length > 0 and file does no have .nmt extension 
EscapedFile=`/bin/ls -b $1`
#echo "filename --> $1"
   if [[ -a $1 && (! -d $1 ) && -s $1 && ( ! -a $1.nmt ) ]] ; then
      #echo Copying to NMT -- $1
      #lftp -c "open -u nmt,1234 192.168.1.121 && cd SATA_DISK/Video/TV && put $1 " && #touch $1.nmt
      chmod a+rw "$1"
      cp "$1" /work/tv_complete/ && touch $1.nmt && echo "Copied $1 --> /work/tv_complete"
      strActive=1
   fi

}


function DELETEFILES() {
   # for all files/dirs older then 15 days
   for FILE in `ls -d1 *(m+15) 2> /dev/null`
   do
      # if file exists and file length > 0 and .nmt file exists also 
      if [[ -a $FILE && -s $FILE && -a $FILE.nmt ]] ; then
         #echo deleting $FILE 
         rm -v $FILE
         rm -v $FILE.nmt
         strActive=1
      fi
   done
}

umask 000
# Check if already running
if [[ `ps -e | grep -c "tvtorrentmove"` -gt 1 ]] ; then
   echo already running!!!!
   exit
fi

cd /work/deluge/tv/complete/
if [[ -n $1 ]] ; then
   #If arg exists:
   MAIN 2>&1 | tee -a /work/${0##*/}.log
else
   MAIN >> /work/${0##*/}.log 2>&1
fi
# Clean up log file
sed -i "/^DELETE/ d" /work/${0##*/}.log
exit

