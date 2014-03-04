#!/bin/bash

source ./pref.cfg


youtube-dl -e --get-id $1 > $yt/tmp
sed -i -e 's/ /_/g' $yt/tmp
awk '{key=$0; getline; print $0" " key "";}' $yt/tmp > $yt/$2.list
rm $yt/tmp
notify-send " PMHT " "Video list retrieval for $1 is finished. You can now, watch the videos."
