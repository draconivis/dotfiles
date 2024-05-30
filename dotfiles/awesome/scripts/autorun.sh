#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

# run "redshift-gtk"
run "nm-applet"
# run "easyeffects"
# run "flameshot"
