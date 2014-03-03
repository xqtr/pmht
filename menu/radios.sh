#!/bin/bash

source ./pref.cfg

function youporn_streamer() {
youtube-dl -q -o - "$1" | mplayer -really-quiet -fs -ao alsa - 
}

#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi

categories=$(cat $menu/radios.xml | grep "<area name" | cut -d "\"" -f2 )

if [ "$(echo $categories)" = "" ]
then 
  dialog --msgbox "No Categories found..." 5 30
  exec $ecdir/emucom
fi

dialog --title " Online Radio Stations " --cancel-label "Back" --column-separator , --no-items --menu "Select Category:" $l1 $col $l2 ${categories} 2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	
        cat radios.xml | sed -n '/<radio active="True">*/,/\t<\/radio>/p' > $tmp/radio_tmp
	stations=$(cat $tmp/radio_tmp | grep "<name>" | sed -n 's:.*<name>\(.*\)</name>.*:\1:p' | tr ' ' '_')

	dialog --title " Online Radio Stations " --cancel-label "Back" --column-separator , --no-tags --menu "Select Station:" $l1 $col $l2 ${stations} 2> $tmp/answer
	if [ "$?" = "0" ]
	then
	  cat $tmp/answer
	else
	  cat $tmp/answer
	fi

# Cancel is pressed
else
rm -f $tmp/vids.$$
rm -f $tmp/options.$$
rm -f $tmp/yp.$$
        exec $ecdir/emucom
fi

rm -f $tmp/vids.$$
rm -f $tmp/options.$$
rm -f $tmp/yp.$$
exit
