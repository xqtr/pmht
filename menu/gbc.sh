#!/bin/bash

source ./pref.cfg


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
    exec $menu/gbc.sh
  fi
fi
}

function popup () {
dialog --backtitle "Poor Mans Home Theater" \
--no-tags --cancel-label "Back" --menu "$2" 18 30 11 \
1 "Play" \
2 "Delete" \
X "Back"  2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	case $ch in
	# /home is selected
	  1) eval $1;;
          2) checkpassword
	     rm -f "$gbc_roms/$2";;
	  X) exec $menu/gbc.sh;;
	  *) exec $menu/gbc.sh;;
        esac
 
# Cancel is pressed
else
        exec $menu/gbc.sh
fi
}

#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi
IFS=$'\n\t'
ls -1 $gbc_roms >$tmp/dirs.$$

if [ "$(cat $tmp/dirs.$$)" = "" ]
then 
  dialog --msgbox "No files found..." 5 30
  rm -f $tmp/dirs.$$
  unset IFS 
  exec $menu/emulators.sh
fi


sed 's/^.*$/"&"/g' $tmp/dirs.$$
i=1
while read line
do
  echo $line >>$tmp/options.$$
  i=`expr $i + 1`
done <$tmp/dirs.$$
OPTIONS=`cat $tmp/options.$$`

# clean up
rm -f $tmp/dirs.$$
rm -f $tmp/options.$$

# present menu options
dialog --title "GameBoy Color" --no-items --menu "Please choose a game:" 22 70 23 ${OPTIONS} 2> $tmp/answer


if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	cmd="$gbc -F -4 \"$gbc_roms/$ch\""
	popup $cmd $ch
	exec $menu/gbc.sh
# Cancel is pressed
else
        exec $menu/emulators.sh
fi
unset IFS 
exec
