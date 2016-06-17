#!/usr/bin/env bash

source "_lib.sh"

log "--- Start: Install redis ---"

if [[ ! -e /usr/local/bin/redis-server ]]; then

  if [[ ! -f /vagrant/scripts/redis-stable.tar.gz ]]; then
    wget http://download.redis.io/redis-stable.tar.gz
  fi

  tar xvzf redis-stable.tar.gz
  cd redis-stable

  make
  make install

  cd ../

  rm -rf redis-stable
  rm -f redis-stable.tar.gz

  mkdir -p /etc/redis/
  mkdir -p /var/redis/6379/
fi

cp "/vagrant/scripts/conf/$1" /etc/redis/6379.conf
cp "/vagrant/scripts/conf/$2" /etc/redis/6379-sentinel.conf

log "--- End: Install redis ---"