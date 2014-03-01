#!/bin/bash

source ./pref.cfg

idletime=$(w | grep $(cat tty.info | cut -d"/" -f3,4) | tr -s " " | cut -d" " -f5)

echo $idletime | sed -E 's/(.*):(.+):(.+)/\1*3600+\2*60+\3/;s/(.+):(.+)/\1*60+\2/' | bc


