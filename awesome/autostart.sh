#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run compton --config ~/.config/compton/compton.conf
run discord
run /opt/tutanota-desktop-linux.AppImage