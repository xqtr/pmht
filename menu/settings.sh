#!/bin/bash

source ./pref.cfg
tty > tty.info
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
    exec $ecdir/emucom
  fi
fi
}


dialog --backtitle "Poor Mans Home Theater" \
--begin 3 3 --cancel-label "Back" --no-tags --menu " Settings " 16 30 9 \
1 "Password" \
2 "Theme" \
3 "Update System" \
X "Back to main menu"  2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	case $ch in
	# /home is selected
	  1) checkpassword
	     dialog --passwordbox  "Enter new password..." 8 30 2>$menu/password;;
	  2) exec $menu/theme.sh;;
	  3) pass=$(dialog --passwordbox  " Enter your Admin password to update system..." 8 50 3>&1 1>&2 2>&3)
	   if [ "$?" = "0" ] 
	   then
             echo $pass | sudo -S apt-get update && sudo apt-get upgrade
	   fi;;
	  X) exec $ecdir/emucom;;
	  *) exec $ecdir/emucom;;
        esac
 
# Cancel is pressed
else
        exec $ecdir/emucom
fi
exec $menu/settings.sh
exit

