#!/usr/bin/env bash

cd "/vagrant/scripts/"

# Useful func
source "_lib.sh"

# Start serious things here!

log "Update"
apt-get update

# Install default
source bootstrap.sh

# Install Redis instance
source bootstrap_redis.sh "$1" "$2"

# Install Supervisor
source bootstrap_supervisor.sh

log "Setup complete!"