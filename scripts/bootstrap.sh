#!/usr/bin/env bash

source "_lib.sh"

log "--- Start: Install default package ---"

package sudo
package vim-nox
package ntp
package ntpdate
package bash-completion
package make
package build-essential
package fail2ban
package htop
package git
package whois
package rubygems

# clean a bit
apt-get autoremove -y

log "--- End: Install default package ---"