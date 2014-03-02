
#dialog --title " Admin Priviliges needed " --passwordform "Please enter sudo password" 8 31 1 "Password:" 1 1 "" 1 11 15 15 

source pref.cfg

dialog --title "Installation..." --yesno "Make sure you have edited the pref.cfg file, before continue.\n\nAlso check the source of this file. This script comes with no warranty. \n\nProceed with installation?" 20 60

if [ "$?" = "0" ]
then
sudo apt-get install -y libgtk2.0-0:i386
sudo apt-get install -y zsnes
sudo apt-get install -y visualboyadvance
sudo apt-get install -y vbaexpress
sudo apt-get install -y pcsxr
sudo apt-get install -y desmume
sudo apt-get install -y mupen64plus
sudo apt-get install -y rsstail
sudo apt-get install -y cmatrix
sudo apt-get install -y moc
sudo apt-get install -y wmctrl
sudo apt-get install -y git
sudo rm -f /etc/apt/sources.list.d/sdlmame4ubuntu.*
sudo add-apt-repository ppa:c.falco/mame
sudo add-apt-repository ppa:c.falco/umame
sudo apt-get update
sudo apt-get install -y mame

sudo apt-get install -y python-pip python-dev build-essential
sudo pip install --upgrade pip
sudo pip install --upgrade virtualenv 
sudo pip install mps
sudo pip install pms-youtube
sudo apt-get install -y youtube-dl
sudo apt-get install rtmpdump

sudo pip install livestreamer

echo blue > $ecdir/theme
#cp $menu/.dialogrc ~/.dialogrc
chmod +x ./menu/*.sh
chmod +x emucom
chmod +x pmht.sh
chmod +x ./apps/fusion
chmod +x ./apps/osmose996
dialog --title " Installation Complete " --msgbox "Installation is now complete. Make sure that no errors appeared during package installation. After this, configure each emulator and set appropriate paths to file preg.cfg\n\nEnjoy..." 10 60
clear
else
  clear
  exit
fi
exit
