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
  dialog --passwordbox  " To proceed you must enter the password... " 8 50 2>$tmp/pmht_tmp.$$
  newpass=$(cat $tmp/pmht_tmp.$$)
  if [ "$oldpass" != "$newpass" ]
  then
    dialog --msgbox "Wrong Password!!!" 5 30
    rm -f $tmp/pmht_tmp.$$
    exec $menu/movies.sh
  fi
fi
}

function popup () {
dialog --backtitle "Poor Mans Home Theater" \
--cancel-label "Back" --no-tags --menu "$2" 18 30 11 \
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
	     rm -f "$movies/$2";;
	  X) exec $menu/movies.sh;;
	  *) exec $menu/movies.sh;;
        esac
 
# Cancel is pressed
else
        exec $menu/movies.sh
fi
}

IFS=$'\n\t'
ls -1 $movies >$tmp/dirs.$$

if [ "$(cat $tmp/dirs.$$)" = "" ]
then 
  dialog --msgbox "No files found..." 5 30
  rm -f $tmp/dirs.$$
  unset IFS 
  exec $ecdir/emucom
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
dialog --title " Movies " --cancel-label "Back" --no-items --menu "Please choose a file to play:" $l1 $col $l2 ${OPTIONS} 2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	cmd="$mplayer -f $movies/\"$ch\""
	popup $cmd "$ch"
	
	exec $menu/movies.sh
# Cancel is pressed
else
        exec $ecdir/emucom
fi
unset IFS 
exit
