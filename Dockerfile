FROM alpine
RUN apk add --no-cache samba \
&& mkdir -p /var/data/timemachine \
&& mkdir /temp
ADD ./files/smb.conf /etc/samba/
ADD ./files/addBackupUser.sh /
ADD ./files/.com.apple.TimeMachine.quota.plist /temp/
VOLUME ["/var/data/timemachine"]
EXPOSE 445/tcp
EXPOSE 137/tcp
EXPOSE 139/tcp
EXPOSE 137/udp
EXPOSE 138/udp
ENTRYPOINT ["/usr/sbin/smbd", "--foreground", "--log-stdout", "--no-process-group"]