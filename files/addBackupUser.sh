#!/usr/bin/env ash
if [[ "$#" -ne 1 ]]; then
    echo "Usage: addBackupUser [username]"
    exit 1
else
    echo "Enter new password"
    read -s pw1
    echo "Confirm password"
    read -s pw2
    if [[ "$pw1" = "$pw2" ]]; then
        adduser $1 -D -H -G timecapsule \
        && yes "$pw1" | smbpasswd -a $1 \
        && mkdir -m 700 /var/data/timemachine/$1 \
        && cp /temp/.com.apple.TimeMachine.quota.plist /var/data/timemachine/$1/.com.apple.TimeMachine.quota.plist \
        && chown -R $1 /var/data/timemachine/$1 \
        && echo "TimeCapsule user added" \
        && exit 0
    else
        echo "Passwords missmatch"
        exit 1
    fi
fi
