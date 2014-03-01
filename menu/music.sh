#!/bin/bash

source ./pref.cfg

#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi


ps -A | grep mocp > null
if [ "$?" != "0" ]
  then
    mocp -S > null
fi

dialog --no-tags --menu " Music & Sound " 20 30 16 \
1 "Manage Music [mocp]" \
2 "Play/Pause" \
3 "Next Song" \
4 "Previous Song" \
5 "Track Info" \
6 "Jump Forward 10s" \
7 "Jump Backward 10s" \
8 "Set Volume" \
9 "Volume Up 10%" \
a "Volume Down 10%" \
b "Volume Off" \
c "Shutdown MOCP" \
X "Back to Main Menu" 2> answer

if [ "$?" = "0" ]
then
	ch=$(cat answer)
	case $ch in
	# /home is selected
	  1) mocp
             exec $menu/music.sh;;
          2) mocp -G
             exec $menu/music.sh;;
	  3) mocp -f
             exec $menu/music.sh;;
	  4) mocp -r
             exec $menu/music.sh;;
          5) infotext=$(mocp -i)
  	     dialog --msgbox "$infotext" 20 60
             exec $menu/music.sh;;
          6) mocp -k 10
             exec $menu/music.sh;; 
          7) mocp -k -10
             exec $menu/music.sh;; 
          8) dialog --rangebox "Set Volume" 2 70 0 100 50 2> answer
	     vol=$(cat answer)
	     mocp -v $vol
             exec $menu/music.sh;; 
          9) mocp -v +10%
             exec $menu/music.sh;; 
          a) mocp -v -10%
             exec $menu/music.sh;;
          b) mocp -v 0%
             exec $menu/music.sh;; 
          c) mocp -x
             exec $menu/music.sh;; 
	  X) exec $ecdir/emucom;;
        esac
 
# Cancel is pressed
else
       exec $ecdir/emucom
fi
