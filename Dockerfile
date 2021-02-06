FROM alpine:3.13.1

LABEL maintainer="Onfido, KubeOps Skills <support@kubeops.guru>"

# permissions
ARG CONTAINER_UID=1000
ARG CONTAINER_GID=1000

# install docker tool
RUN export CONTAINER_USER=dockercleanup && \
    export CONTAINER_GROUP=dockercleanup && \
    addgroup -g $CONTAINER_GID dockercleanup && \
    adduser -u $CONTAINER_UID -G dockercleanup -h /usr/bin/dockercleanup.d -s /bin/bash -S dockercleanup 

RUN apk add --update \
    bash \
    docker \
    tini \
    tar \
    gzip \
    wget && \
    mkdir -p /usr/bin/dockercleanup.d && \
    wget --no-check-certificate -O /tmp/go-cron.tar.gz https://github.com/michaloo/go-cron/releases/download/v0.0.2/go-cron.tar.gz && \
    tar xvf /tmp/go-cron.tar.gz -C /usr/bin && \
    apk del \
    wget \
    && rm -rf /var/cache/apk/* && rm -rf /tmp/*

COPY docker-entrypoint.sh /usr/bin/dockercleanup.d/docker-entrypoint.sh
COPY docker-registry-cleanup.sh /usr/bin/dockercleanup.d/docker-registry-cleanup.sh

ENTRYPOINT ["/sbin/tini","--","/usr/bin/dockercleanup.d/docker-entrypoint.sh"]
CMD ["cron"]