#!/bin/bash

source ./pref.cfg

#tty > tty.info
#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi

i=1
rm -f /tmp/options.$$
while read line
do
  echo $i ${line// /_} >>/tmp/options.$$
  i=`expr $i + 1`
done <$menu/radios.txt
OPTIONS=`cat /tmp/options.$$`

dialog --title " Online Radio Stations " --column-separator "|" --menu "Choose a station:" $l1 $col $l2 ${OPTIONS} 2> answer

if [ "$?" = "0" ]
then
	ch=$(cat answer)

	mplayer -ao alsa -really-quiet $(cat $menu/radios.txt | sed "$ch!d" | cut -d"|" -f2)

 rm -f /tmp/options.$$
# Cancel is pressed
else
  exec $ecdir/emucom
fi
exec $menu/oradio.sh
rm -f /tmp/options.$$
exit

