#!/bin/bash

source ./pref.cfg
tty > tty.info
#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi



dialog --backtitle "Poor Mans Home Theater" \
--no-tags --menu " Restricted Area " 16 30 9 \
1 "Youporn" \
2 "Tube8" \
3 "Redtube" \
4 "Youjizz" \
5 "X Video" \
X "Back to main menu"  2> answer

if [ "$?" = "0" ]
then
	ch=$(cat answer)
	case $ch in
	# /home is selected
	  1) exec $menu/youporn.sh;;
	  2) exec $menu/tube8.sh;;
	  3) exec $menu/redtube.sh;;
	  4) exec $menu/youjizz.sh;;
	  5) exec $menu/xvideo.sh;;
	  X) exec $ecdir/emucom;;
	  *) exec $ecdir/emucom;;
        esac
 
# Cancel is pressed
else
        exec $ecdir/emucom
fi
exec $ecdir/emucom
exit

