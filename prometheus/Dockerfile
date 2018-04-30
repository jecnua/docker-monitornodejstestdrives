FROM ubuntu:16.04

MAINTAINER jecnua "fabrizio.sabatini.it@gmail.com"

RUN mkdir -p /src

COPY package.json package.json
COPY /src/* /src/
COPY Dockerfile /Dockerfile

# With node 8 you don't need to install npm
RUN apt-get update && \
  apt-get install -y curl && \
  curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
  apt-get update && \
  apt-get install -y nodejs && \
  npm install

# ENV

# Metadata params
ARG BUILD_DATE
ARG VERSION
ARG VCS_URL
ARG VCS_REF

# Metadata
LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="monitor-nodejs-prom" \
  org.label-schema.description="Testing monitoring nodejs with prometheus exporter"  \
  org.label-schema.vcs-url=$VCS_URL \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.version=$VERSION \
  com.jecnua.docker.dockerfile="/Dockerfile" \

# ENTRYPOINT ["/usr/bin/nodejs /server.js"]
CMD [ "npm", "start" ]
