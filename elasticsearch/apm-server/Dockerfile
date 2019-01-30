FROM ubuntu:18.04

MAINTAINER jecnua "fabrizio.sabatini.it@gmail.com"

# RUN
RUN apt-get update && \
  apt-get -y install wget curl nano gnupg2 && \
  wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
  apt-get install -y apt-transport-https && \
  echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-6.x.list && \
  apt-get update && \
  apt-get install -y apm-server && \
  update-rc.d apm-server defaults 95 10

COPY apm-server.yml /etc/apm-server/apm-server.yml

# ENV

# Metadata params
ARG BUILD_DATE
ARG VERSION
ARG VCS_URL
ARG VCS_REF

# Metadata
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
