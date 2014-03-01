#!/bin/bash

source ./pref.cfg

#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi

function textbox {
  dialog --cr-wrap --title " News " --textbox "$1" $l1 $col
}

dialog --clear --column-separator ! --no-tags --menu " News " 17 40 10  \
1 "World News" \
2 "Greek News" \
3 "Scientific News" \
4 "Sport News" \
5 "Kid" \
6 "Health" \
X "Back to Main Menu" 2> answer

if [ "$?" = "0" ]
then
	ch=$(cat answer)
	case $ch in
	# /home is selected
	  1) rsstail -1 -d -u $rssworld | sed -e 's/Title:/\nΤιτλος\n/g' | sed -e 's/Description:/\nΠεριγραφη\n/g' | fold -s -w $fold_width > rss
             textbox rss
	     exec $menu/rss.sh
	     exit;;
          2) rsstail -1 -d -u $rssnews | sed -e 's/Title:/\nΤιτλος\n/g' | sed -e 's/Description:/\nΠεριγραφη\n/g' | fold -s -w $fold_width > rss
 	     textbox rss
	     exec $menu/rss.sh
	     exit;;
	  3) rsstail -1 -d -u $rsstech | sed -e 's/Title:/\nΤιτλος\n/g' | sed -e 's/Description:/\nΠεριγραφη\n/g' | fold -s -w $fold_width > rss
 	     textbox rss
	     exec $menu/rss.sh
	     exit;;
	  4) rsstail -1 -d -u $rsssport | sed -e 's/Title:/\nΤιτλος\n/g' | sed -e 's/Description:/\nΠεριγραφη\n/g' | fold -s -w $fold_width > rss
 	     textbox rss
	     exec $menu/rss.sh
	     exit;;
	  5) rsstail -1 -d -u $rsskid | sed -e 's/Title:/\nΤιτλος\n/g' | sed -e 's/Description:/\nΠεριγραφη\n/g' | fold -s -w $fold_width > rss
 	     textbox rss
	     exec $menu/rss.sh
	     exit;;
	  6) rsstail -1 -d -u $rsshealth | sed -e 's/Title:/\nΤιτλος\n/g' | sed -e 's/Description:/\nΠεριγραφη\n/g' | fold -s -w $fold_width > rss
 	     textbox rss
	     exec $menu/rss.sh
	     exit;;
	  X) exec $ecdir/emucom
	     exit;;
        esac
 
# Cancel is pressed
else
        exec $ecdir/emucom
fi
exit
