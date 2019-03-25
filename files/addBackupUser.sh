#!/usr/bin/env ash
adduser $1 --shell /bin \
&& smbpasswd -a $1 \
&& mkdir -m 700 /var/data/timemachine/$1 \
&& cp /temp/.com.apple.TimeMachine.quota.plist /var/data/timemachine/$1/.com.apple.TimeMachine.quota.plist \
&& chown -r $1 /var/data/timemachine/$1
