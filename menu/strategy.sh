#!/bin/bash

source ./pref.cfg

#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi

dialog --clear --column-separator ! --no-tags --menu "Strategy Games" 22 70 23  \
1 "Advanced Wars !GBA" \
2 "Advanced Wars !PSX" \
3 "Advanced Wars !NEOGEO" \
4 "Advanced Wars !Genesis" \
5 "Zelda the Return of the asshole yeah.... !NES" \
X "Back to Main Menu" 2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	case $ch in
	# /home is selected
	  1) $gba $gba_roms/"Advanced Wars  # GBA.GBA"
	     $menu/strategy.sh;;
          2) echo ;;
	  3) echo ;;
	  4) echo ;;
	  X) $ecdir/emucom;;
        esac
 
# Cancel is pressed
else
        $ecdir/emucom
fi

