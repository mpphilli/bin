#!/bin/zsh
# vim:softtabstop=3:shiftwidth=3:expandtab:foldmethod=indent:number 
#setopt XTRACE 

function MAIN() {
   # find video files to move
   for FILE in `find . -size +100M -type f -print0`
   do
      MOVEFILES $FILE
   done
   if [[ -n $strActive ]] ; then
      echo -e " Finished -- `date`"
      echo -e "**************************************************"
   fi
exit
}


function MOVEFILES() {
   # if file exists and file length > 0 and file does no have .nmt extension 
echo filename --> $1
   if [[ -a $1 && (! -d $1 ) && -s $1 && ( ! -a $1.nmt ) ]] ; then
      echo Copying to NMT -- $1
      #lftp -c "open -u nmt,1234 192.168.1.121 && cd SATA_DISK/Video/TV && put $1 " && touch $1.nmt
      strActive=1
   fi

}


function DELETEFILES() {
   # for all files/dirs older then 3 days
   for FILE in `ls -d *(m+3) 2> /dev/null`
   do
      # if file exists and file length > 0 and .nmt file exists also 
      if [[ -a $FILE && -s $FILE && -a $FILE.nmt ]] ; then
         #echo deleting $FILE AND $FILE.mnt
         #rm -vr $FILE
         #rm -v  $FILE.nmt
         strActive=1
      fi
   done
}



# Check if already running
if [[ `ps -e | grep -c "nmttransfer"` -gt 1 ]] ; then
   echo already running!!!!
   exit
fi

cd /work/sickbeard
if [[ -n $1 ]] ; then
   #If arg exists:
   MAIN 2>&1 | tee -a ~/${0##*/}.log
else
   MAIN >> ~/${0##*/}.log 2>&1
fi
exit

