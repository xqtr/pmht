#!/bin/bash

source ./pref.cfg

#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi

dialog --clear --cancel-label "Back" --no-tags --menu " Exit Menu " 12 30 5 \
1 "Exit" \
2 "ShutDown PC" \
3 "Logout" \
4 Reboot \
5 "Back to Main Menu" 2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	case $ch in
	# /home is selected
	  1) clear;rm -f $ecdir/maximized;exit;;
	2) pass=$(dialog --passwordbox  " Enter your Admin password to shutdown computer... " 8 50 3>&1 1>&2 2>&3)
	   if [ "$?" = "0" ] 
	   then
	     rm -f $ecdir/maximized
             echo $pass | sudo -S shutdown -h now
	   fi;;
	  3) rm -f $ecdir/maximized;logout;;
	  4) rm -f $ecdir/maximized;reboot;;
	  5) exec $ecdir/emucom;;
        esac
 
# Cancel is pressed
else
       exec $ecdir/emucom
fi
