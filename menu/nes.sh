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
IFS=$'\n\t'
ls -1 $nes_roms >$tmp/dirs.$$

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
dialog --title "Super NES" --cancel-label "Back" --no-items --menu "Please choose a game:" $l1 $col $l2 ${OPTIONS} 2> $tmp/answer


if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	$nes $nes_roms/$ch
	exec $menu/nes.sh
# Cancel is pressed
else
        exec $menu/emulators.sh
fi
unset IFS 
exit
