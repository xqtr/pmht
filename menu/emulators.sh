#!/bin/bash

source ./pref.cfg

#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi

function infobox {
  dialog --msgbox "$1" 10 40
}

dialog --clear --column-separator ! --no-tags --menu "Console Emulators" 22 70 23  \
1 "GameBoy Advanced" \
2 "GameBoy Color" \
3 "GameCube" \
4 "Nintendo 64" \
5 "Nintendo DS" \
6 "Nintendo NES" \
7 "Sega Master System & Gamegear" \
8 "Sega Genesis" \
9 "Sega Saturn" \
10 "Sega Mega Drive" \
11 "Multiple Arcade Machine Emulator (MAME)" \
12 "Playstation One" \
X "Back to Main Menu" 2> answer

if [ "$?" = "0" ]
then
	ch=$(cat answer)
	case $ch in
	# /home is selected
	  1) exec $menu/gba.sh;;
          2) exec $menu/gbc.sh;;
	  3) infobox "This function is not enabled yet"
	     exec $menu/emulators.sh;;
	  4) exec $menu/n64.sh;;
	  5) exec $menu/nds.sh;;
	  6) exec $menu/nes.sh;;
	  7) exec $menu/sms.sh;;
	  8) exec $menu/genesis.sh;;
	  9) infobox "This function is not enabled yet"
	     exec $menu/emulators.sh;;
	  10) exec $menu/megadrive.sh;;
	  11) exec $menu/mame.sh;;
	  12) exec $menu/psx.sh;;
	  X) exec $ecdir/emucom;;
        esac
 
# Cancel is pressed
else
        exec $ecdir/emucom
fi

