#!/bin/bash

source ./pref.cfg
#tty > tty.info
#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi


#awk '{key=$0; getline; print $0"," key;}' ytbak

function checkpassword () {
oldpass=$(cat $menu/password)
if [ "$oldpass" != "" ]
then 
  dialog --passwordbox  " To proceed you must enter the password... " 8 50 2>$tmp/pmht_tmp.$$
  newpass=$(cat $tmp/pmht_tmp.$$)
  if [ "$oldpass" != "$newpass" ]
  then
    dialog --msgbox "Wrong Password!!!" 5 30
    rm -f $tmp/pmht_tmp.$$
    exec $menu/youtube.sh
  fi
fi
}

function videolist() {
OPTIONS=`cat $yt/$1.list`
dialog --backtitle "Poor Mans Home Theater" --cancel-label "Back" --no-tags --menu " Youtube Channel Video List " $l1 $col $l2 ${OPTIONS} 2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
        youtube-dl -q -o - http://www.youtube.com/watch?v=$ch | vlc -f -q -
else
  exec $menu/youtube.sh
fi

}

function getchannel() {
dialog --backtitle "Poor Mans Home Theater" \
--no-tags --cancel-label "Back" --menu " Youtube Channel Video List " 10 30 3 \
1 "Update" \
2 "View List of Videos" \
3 "Delete" 2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
        url=$(cat $yt/list.txt | grep $1 | cut -d, -f2)
	id=$(echo $url | rev | cut -d/ -f1 | rev)
	case $ch in
	# /home is selected
	  1) dialog --msgbox "Ready to retrieve video list. Because it will take a while, the procedure will be in the background. When it is finished you will be notified." 8 50
	     $menu/yt_getchannel.sh $url $id &;;
	  2) videolist $id;sleep 5;;
	  3) checkpassword
		rm -f $yt/$id.list
		sed -i /$id/d  $yt/list.txt;;
	  *)   exec $ecdir/emucom;;
        esac
 
# Cancel is pressed
else
  exec $menu/youtube.sh
fi

}

function listchannels() {
channels=$(cat $yt/list.txt)

dialog --backtitle "Poor Mans Home Theater" \
--cancel-label "Back" --no-tags --column-separator , --menu " Youtube Channel " $l1 $col $l2 ${channels} 2>$tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
        getchannel $ch

else
  exec $menu/youtube.sh
fi

}

dialog --backtitle "Poor Mans Home Theater" \
--no-tags --cancel-label "Back" --menu " Youtube Channels" 11 30 4 \
1 "Navigate with MPSYT" \
2 "Add" \
3 "List" \
4 "Delete all" 2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	case $ch in
	# /home is selected
	  1) mpsyt;;
	  2) dialog --form "Enter complete path of channel/user/list.\n\nExample:\nhttp://www.youtube.com/user/01032010814" 12 60 2 "Name for channel:" 1 1 "" 1 19 50 255 "Link:" 2 1 "http://www.youtube.com/" 2 19 50 255 2>$tmp/answer
		if [ "$?" = "0" ]
		then
		name=$(sed '1q;d' $tmp/answer | sed -e 's/ /_/g')
		link=$(sed '2q;d' $tmp/answer)
		echo "$(echo $link | rev | cut -d/ -f1 | rev)" "$name","$link" >> $yt/list.txt
		fi;;
	  3) if [ -e "$yt/list.txt" ]
  		then
 		  listchannels
		fi;;
	  4) checkpassword
		rm -f $yt/*;;
	  *)   exec $ecdir/emucom;;
        esac
 
# Cancel is pressed
else
  exec $ecdir/emucom
fi
  exec $menu/youtube.sh
exit

