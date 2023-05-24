#!/bin/sh

[ -z "$1" ] && notify-send "Hello World" 
[ -n "$1" ] && notify-send "$1"
