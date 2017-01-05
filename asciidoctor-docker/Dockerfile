FROM alpine:3.5

ENV PHANTOMJS_VERSION 2.1.1
COPY *.patch /

RUN apk add --update --no-cache ruby asciidoctor ca-certificates rsync libstdc++ nodejs && \
    update-ca-certificates && \
    apk add --no-cache --virtual build-dependencies build-base libffi-dev ruby-dev && \
    gem install --no-ri --no-rdoc coderay guard io-console guard-shell guard-livereload rack rack-livereload eventmachine && \
    gem cleanup && \
    npm install -g mermaid && \
    npm cache clean && \
    mkdir /mirror && \
    apk del build-dependencies && \
    rm -rf /tmp/*

RUN apk update \
  && apk add --no-cache curl fontconfig \
  && mkdir -p /usr/share && cd /usr/share \
  && curl -L https://github.com/Overbryd/docker-phantomjs-alpine/releases/download/2.11/phantomjs-alpine-x86_64.tar.bz2 | tar xj \
  && ln -s /usr/share/phantomjs/phantomjs /usr/bin/phantomjs \
  && phantomjs --version

WORKDIR /documents
VOLUME /documents

ADD watcher.rb /watcher.rb

CMD ["/bin/sh","-c","trap 'exit 0' INT; tail -f /dev/null"]