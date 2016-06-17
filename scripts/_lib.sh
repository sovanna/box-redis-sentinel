#!/usr/bin/env bash

function log() {
  echo "* [selina-cloud] $1"
}

function package() {
  if [[ "$(dpkg --get-selections | grep "$1")" != "" ]]; then
    log "$1 is already installed. Skipping!"
  else
    log "Installing $1"
    apt-get install "$1" -y
  fi
}