#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

# run "redshift-gtk"
run "nm-applet"
run "xset r rate 175 100"
# run "easyeffects"
# run "flameshot"
