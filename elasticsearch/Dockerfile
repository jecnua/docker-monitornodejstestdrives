FROM ubuntu:18.04

RUN mkdir -p /src

COPY package.json package.json
COPY /src/* /src/
COPY Dockerfile /Dockerfile

RUN apt-get update \
  && apt-get install --no-install-recommends -y npm nodejs curl wget nano \
  && npm install \
  && npm install elastic-apm-node@2.5.1 --save \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# ENV

# Metadata params
ARG BUILD_DATE
ARG VERSION
ARG VCS_URL
ARG VCS_REF

LABEL maintainer="jecnua <fabrizio.sabatini.it@gmail.com>"
LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="monitor-nodejs-elasticapm" \
  org.label-schema.description="Testing elastic apm monitoring with a nodejs \
  express application." \
  org.label-schema.vcs-url=$VCS_URL \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.version=$VERSION \
  org.label-schema.url='https://github.com/jecnua/monitor-nodejs' \
  org.label-schema.schema-version="1.0" \
  com.jecnua.docker.dockerfile="/Dockerfile" \
  com.jecnua.license="MIT"

# ENTRYPOINT ["/usr/bin/nodejs /server.js"]
CMD [ "npm", "start" ]
