FROM balenalib/armv7hf-alpine
RUN ["cross-build-start"]
RUN apk add --no-cache samba \
&& mkdir -p /var/data/timemachine \
&& mkdir /temp \
&& addgroup timecapsule
ADD ./files/smb.conf /etc/samba
ADD files/addBackupUser.sh /usr/bin/addBackupUser
ADD ./files/.com.apple.TimeMachine.quota.plist /temp
RUN chmod +x /usr/bin/addBackupUser
RUN ["cross-build-end"]
VOLUME ["/var/data/timemachine", "/var/lib/samba/private", "/etc"]
EXPOSE 445/tcp
EXPOSE 137/tcp
EXPOSE 139/tcp
EXPOSE 137/udp
EXPOSE 138/udp
ENTRYPOINT ["/usr/sbin/smbd", "--foreground", "--log-stdout", "--no-process-group"]