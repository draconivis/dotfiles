#!/usr/bin/env bash

Xephyr :2 -ac -br -noreset -screen 1920x1080 -dpi 96 &
sleep 1
DISPLAY=:2.0 awesome -c ~/.config/awesome/rc.lua &
instance=$!

while inotifywait -r -e close_write ~/.config/awesome; do
	kill -s SIGHUP $instance
done
