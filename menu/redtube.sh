#!/bin/bash

source ./pref.cfg

function redtube_streamer() {
youtube-dl -q -o - "$1" | mplayer -really-quiet -fs -ao alsa - 
}

#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi

curl -s "http://www.redtube.es" > $tmp/yp.$$


cat $tmp/yp.$$ | grep 'class=' | sed -n -e 's/.*<a href=\"\(.*\)class\=\"s\" >.*/\1/p' > $tmp/vids.$$

if [ "$(cat $tmp/vids.$$)" = "" ]
then 
  dialog --msgbox "No Videos found..." 5 30
  rm -f $tmp/vids.$$
  exec $ecdir/emucom
fi

i=1
while read line
do
id=$(echo $line | cut -d"/" -f2 | cut -d"\"" -f1)
name=$(echo $line | cut -d"/" -f2 | cut -d"\"" -f3)
echo $id "${name// /_}" >>$tmp/options1.$$ 
  i=`expr $i + 1`
done <$tmp/vids.$$
OPTIONS=`cat $tmp/options1.$$`

# present menu options

dialog --title " Redtube.es " --cancel-label "Back" --column-separator " " --no-tags --menu "Select video:" $l1 $col $l2 ${OPTIONS} 2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	redtube_streamer "http://www.redtube.es/"$ch
	exec $menu/redtube.sh
# Cancel is pressed
else
rm -f $tmp/vids.$$
rm -f $tmp/options.$$
rm -f $tmp/yp.$$
exec $menu/restricted.sh
rm -f $tmp/options1.$$
fi
done
rm -f $tmp/vids.$$
rm -f $tmp/options.$$
rm -f $tmp/options1.$$
rm -f $tmp/yp.$$
exit
