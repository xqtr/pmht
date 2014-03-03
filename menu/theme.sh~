#!/bin/bash

source ./pref.cfg
#tty > tty.info
#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi

dialog --backtitle "Poor Mans Home Theater" \
--begin 3 3 --no-tags --cancel-label "Back" --menu " Theme Selection " 16 30 9 \
1 "Blue" \
2 "Red" \
X "Back to main menu"  2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	case $ch in
	# /home is selected
	  1) rm ~/.dialogrc
	     echo blue > $ecdir/theme;;
	  2) cp $menu/.dialogrc ~/.dialogrc
	     echo red > $ecdir/theme;;
	  X) exec $menu/settings.sh;;
	  *) exec $menu/settings.sh;;
        esac
 
# Cancel is pressed
else
  exec $menu/settings.sh
fi
exec $menu/theme.sh
exit

