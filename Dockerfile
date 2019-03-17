FROM alpine
RUN apk add --no-cache samba
ENTRYPOINT ["/usr/sbin/smbd", "--foreground", "--log-stdout"]