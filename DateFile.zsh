#!/bin/zsh

function MAIN () {
   echo $1 > /tmp/DateFile.log
   if [[ -a $1 ]] ; then 
      FilePart0=($1(:r))
      FilePart1=.${$( date +%y%m%d )}
      FilePart2=($1(:e))
      if [[ -n $FilePart2 ]] ; then
          FilePart2=.$FilePart2
      fi
      #echo $FilePart0
      #echo $FilePart1
      #echo $FilePart2
      echo "$1 --> $FilePart0$FilePart1$FilePart2"
      mv $1 $FilePart0$FilePart1$FilePart2
      #mv $1 $1(:r).${$( date +%y%m%d )}
   else
      echo "File not found!"
   fi
}

MAIN $1
   
