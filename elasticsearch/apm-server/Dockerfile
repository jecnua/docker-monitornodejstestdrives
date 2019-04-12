FROM ubuntu:18.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
  && apt-get -y --no-install-recommends install wget curl nano gnupg2 apt-transport-https ca-certificates \
  && wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - \
  && echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list \
  && apt-get update \
  && apt-get install --no-install-recommends -y apm-server=7.0.0 \
  && update-rc.d apm-server defaults 95 10 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY apm-server.yml /etc/apm-server/apm-server.yml

# Metadata params
ARG BUILD_DATE
ARG VERSION
ARG VCS_URL
ARG VCS_REF

# Metadata
LABEL maintainer="jecnua <fabrizio.sabatini.it@gmail.com>"
LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="" \
  org.label-schema.description="" \
  org.label-schema.url="" \
  org.label-schema.vcs-url=$VCS_URL \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.version=$VERSION \
  com.jecnua.docker.dockerfile="/Dockerfile" \
  com.jecnua.license=""

CMD [ "apm-server", "-e", "-E", "output.elasticsearch.hosts=docker.for.mac.localhost:9200" ]
