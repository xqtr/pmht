#!/bin/bash

source ./pref.cfg

#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi

dialog --clear --column-separator ! --no-tags --menu "Platform Games" 22 70 23  \
1 "Bubble Bobble !SMS !*" \
2 "Advanced Wars !PSX !****" \
3 "Advanced Wars !NEOGEO !***" \
4 "Advanced Wars !Genesis !***" \
5 "Zelda the Return of the asshole yeah.... !NES" \
X "Back to Main Menu" 2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	case $ch in
	# /home is selected
	  1) $fusion $sms_roms/"Bubble Bobble.zip" -fullscreen
	     $menu/platform.sh;;
          2) $fusion $sms_roms/"Wonder Boy III - The Dragon's Trap (USA, Europe).zip"  -fullscreen
	     $menu/platform.sh;;
	  3) echo ;;
	  4) echo ;;
	  X) $ecdir/emucom;;
        esac
 
# Cancel is pressed
else
        $ecdir/emucom
fi

