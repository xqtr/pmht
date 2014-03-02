#!/bin/bash

source ./pref.cfg

#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi


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
    exec $menu/mame.sh
  fi
fi
}

function popup () {
dialog --backtitle "Poor Mans Home Theater" \
--no-tags --menu "$2" 18 30 11 \
1 "Play" \
2 "Delete" 2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	case $ch in
	# /home is selected
	  1) eval $1
#Change resolution back to normal, if something goes wrong. 
             xrandr -s $screen_resolution;;
          2) checkpassword
	     rm -f "$mame_roms/$2.zip"
	     exec $menu/emulators.sh;;
	  *) exec $menu/mame.sh;;
        esac
 
# Cancel is pressed
else
        exec $menu/mame.sh
fi
}



IFS=$'\n\t'
ls -1 $mame_roms >$tmp/dirs.mame

if [ "$(cat $tmp/dirs.mame)" = "" ]
then 
  dialog --msgbox "No files found..." 5 30
  rm -f $tmp/dirs.mame
  unset IFS 
  exec $menu/emulators.sh
fi


sed 's/^.*$/"&"/g' $tmp/dirs.mame
i=1
while read line
do
if [ -e "$mame_roms/$line" ]
  then
  line2=$(echo $line | sed 's/.zip//g')
  cat $tmp/gamelist.txt | grep $line2 | sed 's/\"//g' >>$tmp/options.mame
fi
#  echo $line >>$tmp/options.mame
#  i=`expr $i + 1`
done <$tmp/dirs.mame
OPTIONS=`cat $tmp/options.mame`

# clean up
rm -f $tmp/dirs.mame
rm -f $tmp/options.mame

# present menu options
dialog --title "Multiple Arcade Machine Emulator" --cancel-label "Back" --no-items --menu "Please choose a game:" $l1 $col $l2 ${OPTIONS} 2> $tmp/answer


if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer | head -n1 | cut -d " " -f1)
	cmd="$mame \"$ch\""
	popup $cmd $ch
	exec $menu/mame.sh
# Cancel is pressed
else
        exec $menu/emulators.sh
fi
unset IFS 
exit
