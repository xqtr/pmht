#!/bin/bash

source ./pref.cfg

#tty > tty.info
#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi

function mplayerinfo() {
dialog --cr-wrap --title " MPlayer Keys " --textbox $ecdir/guides/mplayer_keys.txt $l1 $col 
}

function wiimote() {
dialog --cr-wrap --title " Wiimote Install " --textbox $ecdir/guides/wiimote.txt $l1 $col 
}

dialog --backtitle "Poor Mans Home Theater" \
--cancel-label "Back" --no-tags --menu " Help " 16 30 9 \
1 "Mplayer Keys" \
2 "Wiimote Install"  2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	case $ch in
	# /home is selected
	  1) mplayerinfo;;
	2) wiimote;;
	  *) exec $ecdir/emucom;;
        esac
 
# Cancel is pressed
else
  exec $ecdir/emucom
fi
exec $menu/help.sh
exit

