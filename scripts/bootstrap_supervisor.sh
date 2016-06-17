#!/usr/bin/env bash

source "_lib.sh"

log "--- Start: Install supervisor ---"

package supervisor

cp /vagrant/scripts/conf/supervisor.conf /etc/supervisor/conf.d/

# Create Supervisor path to log files
if [ ! -d /var/log/supervisord/ ]; then
  mkdir -p /var/log/supervisord/
  touch /var/log/supervisord/supervisord.log
fi

# Restart Supervisor
service supervisor stop
service supervisor start

log "--- End: Install supervisor ---"