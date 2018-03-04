# redmine
FROM redmine:3.4.2

ENV AUTHOR="teachmyself@126.com"

ENV WORKDIR="/usr/src/redmine"
    FILES="/usr/src/redmine/files"
    THEME="${WORKDIR}/public/themes"
    PLUGINS="${WORKDIR}/plugins"
    CONFIG="${WORKDIR}/config"

#COPY config/database.yml ${CONFIG}/
COPY config/configuration.yml ${CONFIG}/
ADD a1_theme-2_0_0.zip ${THEME}/

RUN set -eux; \
        apt-get update && apt-get -y install \
            python-pip \
            unzip \
            && \
        pip install --upgrade pip && pip install --upgrade \
            aliyun-ecs \
            && \
        ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
        dpkg-reconfigure -f noninteractive tzdata && \
        apt-get -y autoremove && \
        rm -rf /usr/share/doc /usr/share/man /var/lib/apt/lists/* && \
        cd ${THEME} && \
        unzip a1_theme-2_0_0.zip && \
        cd ${PLUGINS} && \
        git clone git://github.com/suer/redmine_webhook.git && \
        bundle config mirror.https://rubygems.org https://ruby.taobao.org && \
        bundle install && \
#       rake redmine:plugins:migrate RAILS_ENV=production && \
        chown -R redmine:redmine ${PLUGINS}/redmine_webhook && \
        chown -R redmine:redmine ${THEME}/a1 && \
        chown -R redmine:redmine ${WORKDIR}/config/configuration.yml && \
        ln -s ${WORKDIR}/log /home/redmine && \
        rm -rf \
            /tmp/* \
            /var/cache/apt/ \
            ~/.cache \
            ~/.bundle \
            ~/.gem \
            ${THEME}/a1_theme-2_0_0.zip \
            ${PLUGINS}/redmine_webhook/.git 

WORKDIR ${WORKDIR}

VOLUME /etc/localtime
VOLUME ${FILES}
VOLUME ${THEME}
VOLUME ${CONFIG}
VOLUME ${WORKDIR}/config/configuration.yml

EXPOSE 3000

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
