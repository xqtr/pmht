#!/bin/bash

source ./pref.cfg

#tty > tty.info
#if [ -z $DISPLAY ]
#  then
#    DIALOG=dialog
#  else
#    DIALOG=Xdialog
#  fi

function justinplay () {
livestreamer -Q http://www.justin.tv/$1 $2 --stdout | vlc -f -
}

function justin () {
dialog --backtitle "Poor Mans Home Theater" \
--no-tags --menu " Justin TV " 16 30 9 \
1 "DC & Marvel Comics" \
2 "Simpsons" \
3 "SouthPark" \
4 "Anime" \
5 "Action Movies" \
6 "Star Trek" \
X "Back"  2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	case $ch in
	# /home is selected
	  1) justinplay samsson051 worst;;
	  2) justinplay arconai603 worst;;
	  3) justinplay arconai556 low;;
	  4) justinplay beefpepp worst;;
	5) justinplay booku373 low;;
	6) justinplay downlord_068 worst;;
	  X) exec $menu/otv.sh;;
	  *) exec $menu/otv.sh;;
        esac
 
# Cancel is pressed
else
  exec $menu/otv.sh
fi
}


dialog --backtitle "Poor Mans Home Theater" \
--cancel-label "Back" --no-tags --menu " Greek TV " 21 30 13 \
1 "MEGA" \
2 "ANT1" \
3 "STAR" \
4 "ALPHA" \
5 "Makedonia" \
6 "E TV" \
7 "EDT TV" \
8 "Euronews" \
9 "Greek Cinema" \
10 "Kontra Channel" \
11 "Zougla TV" \
12 "Egnatia TV" \
13 "Star Kentrikhs Lamias" 2> $tmp/answer

if [ "$?" = "0" ]
then
	ch=$(cat $tmp/answer)
	case $ch in
	# /home is selected
	  1) $mplayer http://megahdlive1-f.akamaihd.net/i/live_1@105260/master.m3u8;;
	  2) $mplayer http://wow.ant1.gr:1935/live/smil:mavani.smil/playlist.m3u8;;
	  3) rtmpdump --timeout 20 -q -r "rtmp://37.48.66.244:80/alterweb" -y "alterweb.sdp" -p "http://www.kanalia.eu/" --live --quiet | vlc - -f -q;;
	  4) $mplayer http://alfakanali-lh.akamaihd.net/i/live_1@90368/master.m3u8;;
	  5) rtmpdump -r "rtmp://213.16.167.55:1935/livepkgr/livestream" -W "http://static.ant1.gr/maktvlive.ashx" -p "http://www.maktv.gr/Live" --live | vlc - -f -q;;
	  6) rtmpdump -r "rtmp://213.16.167.187:1935/live/" -y "mpegts_256.stream" --live | vlc - -f -q;;
	7) rtmpdump -r "rtmp://cp115017.live.edgefcs.net:443/live/" -y "jiplive@46638" --live| vlc - -f -q;;
	8) rtmpdump -r "rtmp://fr-par-3.stream-relay.hexaglobe.net:1935/rtpeuronewslive" -y "gr_video750_rtp.sdp" -W "http://gr.euronews.com/media/player_live_1_14.swf" --live | vlc - -f -q;;
	9) rtmpdump -r "rtmp://37.48.66.244:80/cinema" -y "cinema.sdp" -p "http://www.kanalia.eu/" --live | vlc - -f -q;;
	10) rtmpdump -r "rtmp://flashcloud.mediacdn.com/live/kontratv" --live | vlc - -f -q;;
	11) $mplayer http://zouglahd-f.akamaihd.net/i/zougla_1@56341/master.m3u8;;
	12) livestreamer -Q http://www.livestream.com/verginatv best --stdout | vlc -f -;;
	13) livestreamer -Q http://www.dailymotion.com/video/xqjey2_star-lamia-live-streaming_news best --stdout | vlc -f -;;
	  X) exec $ecdir/emucom;;
	  *) exec $ecdir/emucom;;
        esac
 
# Cancel is pressed
else
  exec $menu/otv.sh
fi
exec $menu/greektv.sh
exit

