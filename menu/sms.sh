#!/bin/bash

source ./pref.cfg

lines=$(echo -e "lines"|tput -S)
columns=$(echo -e "cols"|tput -S)
let l1=$lines-2
let l2=$lines-1
let col=$columns-6
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
  dialog --passwordbox  " To proceed you must enter the password... " 8 50 2>/tmp/pmht_tmp.$$
  newpass=$(cat /tmp/pmht_tmp.$$)
  if [ "$oldpass" != "$newpass" ]
  then
    dialog --msgbox "Wrong Password!!!" 5 30
    rm -f /tmp/pmht_tmp.$$
    exec $menu/sms.sh
  fi
fi
}

function popup () {
dialog --backtitle "Poor Mans Home Theater" \
--no-tags --menu "$2" 18 30 11 \
1 "Play" \
2 "Delete" \
X "Back"  2> answer

if [ "$?" = "0" ]
then
	ch=$(cat answer)
	case $ch in
	# /home is selected
	  1) eval $1;;
          2) checkpassword
	     rm -f "$sms_roms/$2";;
	  X) exec $menu/sms.sh;;
	  *) exec $menu/sms.sh;;
        esac
 
# Cancel is pressed
else
        exec $menu/sms.sh
fi
}
IFS=$'\n\t'
ls -1 $sms_roms >/tmp/dirs.$$

if [ "$(cat /tmp/dirs.$$)" = "" ]
then 
  dialog --msgbox "No files found..." 5 30
  rm -f /tmp/dirs.$$
  unset IFS 
  exec $menu/emulators.sh
fi


sed 's/^.*$/"&"/g' /tmp/dirs.$$
i=1
while read line
do
  echo $line >>/tmp/options.$$
  i=`expr $i + 1`
done </tmp/dirs.$$
OPTIONS=`cat /tmp/options.$$`

# clean up
rm -f /tmp/dirs.$$
rm -f /tmp/options.$$

# present menu options
dialog --title "Sega Master System / Gamegear" --no-items --menu "Please choose a game:" $l1 $col $l2 ${OPTIONS} 2> answer


if [ "$?" = "0" ]
then
	ch=$(cat answer)
	cmd="$fusion \"$sms_roms/$ch\" -fullscreen"
	popup $cmd $ch
	exec $menu/sms.sh
# Cancel is pressed
else
        exec $menu/emulators.sh
fi
unset IFS 
exit
