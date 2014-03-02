#!/bin/bash

source ./pref.cfg

#tty > tty.info
#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi

function justinplay () {
livestreamer -Q http://www.justin.tv/$1 $2 --stdout | vlc -f -
}

function justin () {
dialog --backtitle "Poor Mans Home Theater" \
--no-tags --menu " Justin TV " 16 30 9 \
1 "DC & Marvel Comics" \
2 "Simpsons" \
3 "SouthPark" \
4 "Anime" \
5 "Action Movies" \
6 "Star Trek" \
X "Back"  2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	case $ch in
	# /home is selected
	  1) justinplay samsson051 worst;;
	  2) justinplay arconai603 worst;;
	  3) justinplay arconai556 low;;
	  4) justinplay beefpepp worst;;
	5) justinplay booku373 low;;
	6) justinplay downlord_068 worst;;
	  X) exec $menu/otv.sh;;
	  *) exec $menu/otv.sh;;
        esac
 
# Cancel is pressed
else
  exec $menu/otv.sh
fi
}


dialog --backtitle "Poor Mans Home Theater" \
--cancel-label "Back" --no-tags --menu " Online TV " 16 30 9 \
1 "Sky News" \
2 "NBC News" \
3 "ISS Live Stream" \
4 "Al Jazeera" \
5 "Justin TV" \
X "Back"  2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	case $ch in
	# /home is selected
	  1) $mplayer mms://live1.wm.skynews.servecast.net/skynews_wmlz_live300k;;
	  2) $mplayer  mms://msnbc.wmod.llnwd.net/a275/e1/video/100/vh.asf;;
	  3) $mplayer mms://a1709.l1856953708.c18569.g.lm.akamaistream.net/D/1709/18569/v0001/reflector:53708;;
	  4) rtmpdump --timeout 20 -q -r "rtmp://aljazeeraflashlivefs.fplive.net/aljazeeraflashlive-live" -y "aljazeera_eng_high" -w "http://admin.brightcove.com/viewer/us20121120.1354/BrightcoveBootloader.swf" --live --quiet | vlc - -f -q;;
	  5) justin;;
	  X) exec $ecdir/emucom;;
	  *) exec $ecdir/emucom;;
        esac
 
# Cancel is pressed
else
  exec $ecdir/emucom
fi
exec $menu/otv.sh
exit

