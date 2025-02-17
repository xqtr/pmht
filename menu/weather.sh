#!/bin/bash

source ./pref.cfg

#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi

function textbox {
  dialog --cr-wrap --title " Weather " --textbox "$1" $l1 $col
}

function getweather () {
rsstail -1 -d -u http://rss.wunderground.com/auto/rss_full/global/stations/$1.xml?units=metric | sed -e 's/Title:/\nTitle\n/g' | sed -e 's/Description:/\nDescription\n/g' | sed -e 's/\&deg;//g' | sed -e 's/|/\n/g' | sed 's/<[^>]\+>//g' | fold -s -w 60 > rss
}


dialog --clear --column-separator ! --cancel-label "Back" --no-tags --menu " Weather " 17 40 10  \
16716 "Athens" \
16726 "Kalamata" \
16622 "Thessaloniki" \
16627 "Komotini" \
16699 "Chalkida" 2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	getweather $ch
        textbox rss
exec $menu/weather.sh
else
        exec $ecdir/emucom
fi
exit
exec $menu/weather.sh
