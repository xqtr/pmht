#!/bin/bash

source ./pref.cfg

function xvideo_streamer() {
youtube-dl -q -o - "$1" | mplayer -really-quiet -fs -ao alsa - 
}

#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi

curl -s "http://www.xvideos.com" > /tmp/yp.$$


cat /tmp/yp.$$ | grep "<p><a href=\"" | sed -n -e 's/.*<p><a href=\"\(.*\)<\/a><\/p>.*/\1/p' > /tmp/vids.$$

if [ "$(cat /tmp/vids.$$)" = "" ]
then 
  dialog --msgbox "No Videos found..." 5 30
  rm -f /tmp/vids.$$
  exec $ecdir/emucom
fi

i=1
while read line
do
id=$(echo $line | cut -d"/" -f2)
name=$(echo $line | cut -d"/" -f4 | cut -d">" -f1 | cut -d"\"" -f1 )
echo $id $name>>/tmp/options1.$$ 
  i=`expr $i + 1`
done </tmp/vids.$$
OPTIONS=`cat /tmp/options1.$$`

# present menu options

dialog --title " XVideo.com " --column-separator " " --no-tags --menu "Select video:" $l1 $col $l2 ${OPTIONS} 2> answer

if [ "$?" = "0" ]
then
	ch=$(cat answer)
	xvideo_streamer "http://www.xvideos.com/$ch"
	exec $menu/redtube.sh
# Cancel is pressed
else
rm -f /tmp/vids.$$
rm -f /tmp/options.$$
rm -f /tmp/yp.$$
exec $menu/restricted.sh
rm -f /tmp/options1.$$
fi
done
rm -f /tmp/vids.$$
rm -f /tmp/options.$$
rm -f /tmp/options1.$$
rm -f /tmp/yp.$$
exit
