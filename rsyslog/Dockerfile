# rsyslog
FROM alpine:3.6

ENV AUTHOR "teachmyself@126.com"

ENV WORKDIR "/rsyslog"

COPY . ${WORKDIR}
WORKDIR ${WORKDIR}

RUN set -xue; \
        apk update && \
        apk add --no-cache \
#            tzdata \
#            ca-certificates \
            rsyslog \
#            logrotate \
            py2-pip \
            && \
        pip install pip --upgrade && \
        pip install aliyun-ecs --upgrade && \
#        ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
        rm -rf /tmp/* /var/cache/apk/* ~/.cache/* /usr/local/share/man && \
#        sed -i 's/.*\(min\|hourly\|weekly\|monthly\)/\#&/' /var/spool/cron/crontabs/root && \
#        mv ${WORKDIR}/haproxy.logrotate /etc/logrotate.d/haproxy && \
        mv ${WORKDIR}/rsyslogd.conf /etc/rsyslogd.conf && \
        mv ${WORKDIR}/rsyslog.d /etc/rsyslog.d

VOLUME /var/run/rsyslog/dev

# CMD ["sh", "-c", "crond && rsyslogd -n -f /etc/rsyslogd.conf"]
CMD ["sh", "-c", "rsyslogd -n -f /etc/rsyslogd.conf"]
