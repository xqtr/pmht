#!/bin/bash

source ./pref.cfg

#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi

dialog --clear --no-tags --menu " Exit Menu " 12 30 5 \
1 "Exit" \
2 "ShutDown PC" \
3 "Logout" \
4 Reboot \
5 "Back to Main Menu" 2> answer

if [ "$?" = "0" ]
then
	ch=$(cat answer)
	case $ch in
	# /home is selected
	  1) clear;rm -f $ecdir/maximized;exit;;
          2) shutdown -h now;;
	  3) logout;;
	  4) reboot;;
	  5) exec $ecdir/emucom;;
        esac
 
# Cancel is pressed
else
       exec $ecdir/emucom
fi
